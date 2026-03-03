Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6941E67A6D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 05:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxIJs-0005UZ-Ia; Tue, 03 Mar 2026 00:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxIJq-0005Td-H2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 00:29:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxIJo-0006u3-Sd
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 00:29:18 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622NKWqd2049006
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 05:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CzV1xE5LP5frPMIb94o5a/
 qKxfcUAvsY4yhrqKF41vQ=; b=jLfIFnslWfQfhRgti/lK5INs5GkZx5JgHkQQZn
 LivzsGbn4jMe+obuoRjwwZeC0h+6AF8qjfsR2cctQ03QNfQDsvjDkrM0RhA9RKSV
 GyR2l4DDxl2Eaae5u6SnV02hYrjqolrMSmGIb6xRhguZFTaf5s4+od+XfdB6x+ht
 QJiZbGO/kwRGaY/omWREAwBWqZ1o2mLPWy5ylm75dGO4Ya8HNJDj4AeNihSJ1FyX
 4hpFyP3hKTClQMOHXR29Dw8jYoo9UxxHHnVjYfgVD2+0FB9koedYUAlogscBP7T5
 9cbTU3YC/I1whEpdkT+MiszEs+ZMEuBlQ3V0/kmRLMyE9CTQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cncmftnfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:29:12 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d4cdc32cdeso85353573a34.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 21:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772515752; x=1773120552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CzV1xE5LP5frPMIb94o5a/qKxfcUAvsY4yhrqKF41vQ=;
 b=dnBbKJ7Ej9PE6/jFHdrHH85BB6QnGATB3LTJkpNwp0HjQNU25ogGXXfmblg9g134d3
 PRcWO+IjSpQx10ipnLGDIR4gINZ6D/cZR+1WnF/CWPp/byZnF78wBrt2sOEtXT8tyxvH
 bVmT+oOdl3aE5wLqydddy2PtE2v7Yxo8GA1IZYyhSqqmEiwv3uGYAJ57vgMskb3n8EsA
 1w30rS92l3lfqiemY7WfA8m7oJnIKRjQ1wGypVGmeyIWpi8dtWEJj2xwOsts4D/JAusL
 yKJ553jVMxUUAsEZVklU2QVJ1oLrHq7nUd/1F2/KGobuv0ZTOdh3YphvYnsi5wLf3klt
 tquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772515752; x=1773120552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzV1xE5LP5frPMIb94o5a/qKxfcUAvsY4yhrqKF41vQ=;
 b=OXkryNBNCZPS5myzsZ6OTGRQ4USsRYtl+vgesDAEyX9H5Bv4EVcj3cEGti8mi5nap7
 7AoDcKrVRGUVMqr6I1R4VxMkcRQHLgFwdiixybapS85So3ZY9+L2AtVcYiNGMzVoMhLK
 gm0K/O5+QHkIqkkxyacjwoLg8ZW8xgG5qbK6iQJiePtOA72VKcg5s0p12nm0Ou3zfhfP
 K2JJZKdySibD3rSWFCjhGzl/nJoe7hiikZ2wY6Jh+D9isnd0zHty5wt8qcPq6bIvDOrn
 X7PqieuNVn1Lwip6HXMGMWwxrN3x+1GeNO1lBDfcDlf9+irSOlxBs6lyQiMq88CS4g6p
 ifLg==
X-Gm-Message-State: AOJu0YzZNfPpPbj4rfJHb6WeOTDYZ6fMFfzmmFj56SKBMEeykrn/h62R
 9RxNV5QPcdmME/7SzitfFOTY5UwRvvQCXWYFw0pt5XsJ6dBMvN8gsrs18uhbUsb6b1UAE0ICx/3
 hvbkJqmFvyUOZ1gTpTYYOQCfmz7HdfHtSYSvA4xpAH70zj82s/wps+cbQDxUHocf4FQ==
X-Gm-Gg: ATEYQzzscOxKN0xXBXy2hhQNtwkaVXqz5X6U82bZ1S5slKZYBv6+Oq32CDKXXI/4Fi0
 3+QbyEMfyTzhg4me9PSmjjc9jIszFaHg0obp1hURDqJkg3PUWkRzcrtMRDmpZEBuzy42ZVOOoKV
 4BTtZnEhuw3eqiYlRe0kf71nqWms6S9NDq0IY0Tn4DhhXGuUkLgZHhY5n7e7LurZyOAKoM+XUum
 bBw8t7DNY2K3S76Vz4JEmNXXb/TS8F/jIFYQ/zh3+ri9tUY9MefqjWp3f5baW1ADz5/EZx48PBd
 xS/CQZvnU5So7ap9RmvgZ0JdB9O7PxPx73moRLZvw8KPUn/omSXAp4MTDWmHEXFZjCzWIzpBiCh
 r3rcvPdSUCVLl1mDAQpDr9HYCMjJuhVCRh1Dh6w7/YqilTC92lrgcr7HTEAaBb9FDp0Othg==
X-Received: by 2002:a05:6830:6edf:b0:7d1:8be9:e6a0 with SMTP id
 46e09a7af769-7d5be3e32f6mr543787a34.13.1772515752128; 
 Mon, 02 Mar 2026 21:29:12 -0800 (PST)
X-Received: by 2002:a05:6830:6edf:b0:7d1:8be9:e6a0 with SMTP id
 46e09a7af769-7d5be3e32f6mr543775a34.13.1772515751709; 
 Mon, 02 Mar 2026 21:29:11 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586474d4csm13800778a34.9.2026.03.02.21.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 21:29:11 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Alexey Karyakin <akaryaki@qti.qualcomm.com>
Subject: [PATCH v2 1/3] target/hexagon: fix J2_jumptnew/pt predicate check to
 use LSB
Date: Mon,  2 Mar 2026 21:28:59 -0800
Message-Id: <20260303052901.30462-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Br+QAIX5 c=1 sm=1 tr=0 ts=69a671a9 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ivnBtVQm4APjhFw-y08A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: YRKaYnbQGbQiEl8ZIlEn1vvzGf7ESPax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDAzMyBTYWx0ZWRfXyu/kv5QxgbVt
 JKQisxyBS7tpjgUAvjWQR6mUgGIBPKYUvCYqrCp57l6a3rc+Fc91/K1XKz7jK/sj//VeH4LW8jx
 MLGp9ImaZ1r2fPos9qWjAlsgNmRiKfUwzZF9RSNiKwYzf9E04lY3Pc/6sy/oZ/hSmeleIS8DVMl
 6RbTK9vb/GdpkZyacsQxdzPvM3RKgdS7VDqK1O+9kMGhqrM0vmOFpOtQVsuWBEmNO8/RmNsRFGG
 fB4Dd+IOkzrUNmSEgnUG7dRVTJJ0JIjhRmWu9di6mYqxMifoiNX7pCH9Mkz/TCSQaLeM4LyMwpm
 G7LxJVHgZtu3LTvMVhigTuIs6Zlcq5yqjf7deKEUPtDUZnlAFdVB/ljLVf75Ai/4vpnV0RzxBZI
 IKTiKbLIzQDs5umRlkmJsdo4Yk7zfB0gS8oIsVkTjpi6DCyNHnINI4+ucNlxnNmEfocjC3pvNG/
 E0xLu4lvLA6T8QNRlvQ==
X-Proofpoint-GUID: YRKaYnbQGbQiEl8ZIlEn1vvzGf7ESPax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SjJfanVtcHRuZXcgYW5kIEoyX2p1bXB0bmV3cHQgcGFzc2VkIHRoZSByYXcgcHJlZGljYXRlIHZh
bHVlIHRvCmdlbl9jb25kX2p1bXAoKSwgY2hlY2tpbmcgaWYgdGhlIGZ1bGwgOC1iaXQgdmFsdWUg
d2FzIG5vbi16ZXJvLgpSZWZlciB0byBQUk0gU2VjdGlvbiA2LjEuMiAicHJlZGljYXRlLWNvbnN1
bWluZyBpbnN0cnVjdGlvbnMgZXhhbWluZQpvbmx5IHRoZSBsZWFzdC1zaWduaWZpY2FudCBiaXQi
LgoKVGhpcyBpbmNvbnNpc3RlbmN5IGNhdXNlZCBpZiAocDAubmV3KSBqdW1wcyBhbmQgaWYgKHAw
Lm5ldykgbG9hZHMKd2l0aGluIHRoZSBzYW1lIHBhY2tldCB0byBkaXNhZ3JlZSB3aGVuIHRoZSBw
cmVkaWNhdGUgaGFkIHZhbHVlcwpvdGhlciB0aGFuIHRoZSBvbmVzIGdlbmVyYXRlZCBieSBwcmVk
aWNhdGUtZ2VuZXJhdGluZyBpbnN0cnVjdGlvbnMKKGUuZy4gMHg4MCBvciAweEFBIHdoZXJlIGJp
dCAwIGlzIGNsZWFyIGJ1dCB0aGUgdmFsdWUgaXMKbm9uLXplcm8pOiB0aGUganVtcCB3b3VsZCBi
ZSB0YWtlbiB3aGlsZSB0aGUgbG9hZHMgd2VyZSBza2lwcGVkLgoKRml4IGJ5IHJvdXRpbmcgYm90
aCBtYWNyb3MgdGhyb3VnaCBmR0VOX1RDR19jb25kX2p1bXB0KGZMU0JORVcoUHVOKSksCm1hdGNo
aW5nIHRoZSBwYXR0ZXJuIHVzZWQgYnkgZXZlcnkgb3RoZXIgcHJlZGljYXRlZCBqdW1wLgoKRGlz
Y292ZXJlZC1ieTogQWxleGV5IEthcnlha2luIDxha2FyeWFraUBxdGkucXVhbGNvbW0uY29tPgpS
ZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKaW5kZXggN2I5NmRhYjkxODUuLjQ1
Y2NkNTE4ODgzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZy5oCkBAIC05NTEsOSArOTUxLDkgQEAKICNkZWZpbmUgZkdFTl9U
Q0dfSjJfanVtcGZwdChTSE9SVENPREUpIFwKICAgICBmR0VOX1RDR19jb25kX2p1bXBmKGZMU0JP
TEQoUHVWKSkKICNkZWZpbmUgZkdFTl9UQ0dfSjJfanVtcHRuZXcoU0hPUlRDT0RFKSBcCi0gICAg
Z2VuX2NvbmRfanVtcChjdHgsIFRDR19DT05EX0VRLCBQdU4sIHJpVikKKyAgICBmR0VOX1RDR19j
b25kX2p1bXB0KGZMU0JORVcoUHVOKSkKICNkZWZpbmUgZkdFTl9UQ0dfSjJfanVtcHRuZXdwdChT
SE9SVENPREUpIFwKLSAgICBnZW5fY29uZF9qdW1wKGN0eCwgVENHX0NPTkRfRVEsIFB1TiwgcmlW
KQorICAgIGZHRU5fVENHX2NvbmRfanVtcHQoZkxTQk5FVyhQdU4pKQogI2RlZmluZSBmR0VOX1RD
R19KMl9qdW1wZm5ld3B0KFNIT1JUQ09ERSkgXAogICAgIGZHRU5fVENHX2NvbmRfanVtcGYoZkxT
Qk5FVyhQdU4pKQogI2RlZmluZSBmR0VOX1RDR19KMl9qdW1wZm5ldyhTSE9SVENPREUpIFwKLS0g
CjIuMzQuMQoK

