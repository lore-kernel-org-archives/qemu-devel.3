Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60562606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1agdOYn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jz0CFfi9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1D-00026J-0R; Mon, 19 Oct 2026 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw18-00024q-CE
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw15-0003uZ-Dr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZUrK3389785
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=kYYvBDUD8gfrKSSgHkNE3O
 8f+2w+3l4+66eFpehRBBc=; b=X1agdOYnRtg9Y13lV7MwXjm53XcP1u4donf2Cb
 NOHR3AsQp4hjXZIiZC/4Dslq3fF2lbHC9WtN+GSorr/nafwR+txwvrrvjWsqDzIx
 vyter6o0/ExSUNThpkFo/ENx3oxtF2b1MPUZBfsMVgmxab5bcq8wsq7Kmq3b0cEv
 /bWU4JWK6YeylkIsOg7R9jt/IvY+0uZnkXhcEDEc1bU0BcEbzTmn/HGgde7djx4/
 gqXhR3YKEQ0Xm2RFdnRGY2MK11tVmi5IIujBANTD3XT256c6YpvmKFmlyfEqvxfZ
 GX3UQFqLi6oPDVO6yM9pc2iF3Vt/FIiOP94JX7M/n+4E4XAA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0vmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3592749a017so146580eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449576; x=1793054376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kYYvBDUD8gfrKSSgHkNE3O8f+2w+3l4+66eFpehRBBc=;
 b=Jz0CFfi90vPTg3L/vHLKE84bps4OzGJXg3erFzAcWOBLQghr7VFnW0gOtMhlPhnDnc
 nDUfHwJGCy8moyec3QRLSDpHrqi56rIdVMK8//QtQ7WFfj3FleUsj04+we+7yjmJtpYe
 j1Vf+8VkcIP9TUNBEVgjlFG4LJhEBxZpt0XenpLB4tUGxlDiLiGP9P6O53nnKlTDmajA
 qI6ydgcTOjQPMHgzoPv3hPXWmIBAa2KKv9sMOV/p8GWJ8liLwo735LpQ3PK6BfAtIe02
 jGr3QBS/SyOmQeZPM4ecMwVIqQJ0jdcnQ9vHgnOFuJOBEptVpy6yrI+acdj3SVvGwcnJ
 qs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449576; x=1793054376;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kYYvBDUD8gfrKSSgHkNE3O8f+2w+3l4+66eFpehRBBc=;
 b=jJcjSMwmFV6iFy133fHKEQ3SHrA07snhnAro/GbZugZwAdyqW5U8wPfj4zXfVEF8lR
 vzu0oBwe82Bm/qGAWPZObhzsPl2S/6Pr08NpI4vCfLlIK5LO5yskx51Q4tUSXTDUWuj3
 uuHDsdYrTb8e0JY4gLMemVkIE3WkRsvP750CYj8uUzVLrqEFHQ6SUPozceywswSOasVT
 dmSVBXB6U+3VnndoeJ5sWX1oyjhYuyGXmxCljZ4rULe9kJQwVrA3VrbnpPbn5GbkAuVp
 o6rf2VOTdtDpmxtFa/SF6zZjy8/WYijozA3YIDy8i4a706XEjFZiSODk73VMR6DxRQNI
 D+lA==
X-Gm-Message-State: AFq9FYK4do4aTofS8SvLXDMGOKVBa6kjzwbDR+aEI10CRTg5deOmsooX
 NFK4oLwq4YSwxAn3c4Mum7vmHHe69j+6tjZFtg3/ONUbZ/O7oRNRTImJ2oKXxtoez2XworHzoS0
 R8nHkoOqskjzYtXEjXHPy96rgbrI0BwZ4fJtBNEzOjpobrn9UBChqErjKShzWyktJtA==
X-Gm-Gg: AYBFou2NE+NOZJTZjov4ti49nFRkVlP3UbmH2g3dbZxZfYEmjAaHkM5NYLNWtwzS1vp
 5KfyNCfWRfGxHlskgEcTpeLEG9w2NGLUiHjtULgaMM/Qih/L64l52z7UV7LrpBfqUCPEH6xe4E9
 EVyZi3CHjai9XNaJrl732yot1kGhseas1+LP6GRmfHkJExW2FlOkbaq9vBvDD9JvxtDqAgr7zj8
 s49s/n3eCjNyxsrCgdnkaujZb3b9l1V4eFymsbbHbEErf+2trJhCSlArLa55BoMXPtkiW/x8isq
 +bDd6gVaIKdjw1Ii9RstYAX0YvOp3amrlVT1RtpSp1/fd9vbeyK0xciXkEkjKujM11qmi2i2Pyi
 TOu+7BQOmr00itJJevtKgJvaV/rsIFUziykVACDRwt7qVh+g=
X-Received: by 2002:a05:7022:121:b0:146:84fd:7b58 with SMTP id
 a92af1059eb24-18dbe2af657mr778075c88.9.1792449575846; 
 Mon, 19 Oct 2026 15:39:35 -0700 (PDT)
X-Received: by 2002:a05:7022:121:b0:146:84fd:7b58 with SMTP id
 a92af1059eb24-18dbe2af657mr778048c88.9.1792449575252; 
 Mon, 19 Oct 2026 15:39:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm38908474eec.0.2026.10.19.15.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:39:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 0/5] Hexagon: enable MTTCG
Date: Mon, 19 Oct 2026 15:39:28 -0700
Message-Id: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JIpV18DvlzFbegA8yi_RTRe9EO7zLaus
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfXw9NzDaHMIEr0
 pdOIzbBGI9O5fiDheVjs5BWLrNNb8LVrfbsd5fkbwr3I66OklwjzgpxvpDjhGCWVaOSYe8+3INc
 b+SphCFsoeVgkCBUVOoJDb8YLly9/yo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX0ozkh/+c7d+n
 NtzbSYYI7TJFSN1sVBas2AojuUIzUYlSbpUt+lbeEN7BtLQJgnY0SJFWFWMI5Hl5ako0oJXWDXc
 CfWbgJVVwm5QucVVIypeSUKkypet5wUy+sA2wLv5bQuRM00QXmjSeVryePb6EN8u2GNrO/5iVwc
 JVYQSPS6yHe561Ys/XtjP71hODFqoxjjzSJ480qUo18sRCkgNK9L4vIofuttOG6Rh2JO/P+P6Ao
 U7iJDeC5BqK6vWq50c3xPFuXQzZeK15h1AKQV1QFXzcHCihmmnHrUPlbKtD9DtCzsMovfqEGHxz
 2+cb9G3qpgLvV3ccD4ROf7A3H45+TASjfjpn5k6a2op4CEFXnf8ErcZAERz1fpIPbd5TykQ8M4O
 qyzNzHz4Em9BKJ6pC5Bxf925xoyU4QAa4eZXxKluKsDQTeVYesAQ5zX2ZCxqtdtnfUbo8zMItsy
 UOzpX2a6wr7G0nxLAmw==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad69c28 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M5dSWgx6QfBFGVNocYgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: JIpV18DvlzFbegA8yi_RTRe9EO7zLaus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VHVybmluZyBvbiBtdHRjZyBleHBvc2VkIHNvbWUgYnVncywgdGhlIGZpeGVzIGZvciB0aG9zZSBh
cmUgaW5jbHVkZWQgaW4gdGhpcwpzZXJpZXMuCgpBIHByZXZpb3VzIHNlcmllcyAoc2luY2UgbGFu
ZGVkKSBhbHNvIHByb3ZpZGVkIHNvbWUgZml4ZXMgZm9yClRMQi9iYXJyaWVycy9MTC1TQzogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkyNzAyNDM0Ny4zNTQ1Mzg1LTEt
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKRnVsbHkgcmV2aWV3ZWQgc2VyaWVzLCB3aWxs
IHNob3cgdXAgaW4gYSBwdWxsIHJlcSBSZWFsIFNvb24gTm93LgoKSW4gdjI6Ci0gUmVtb3ZlZCB1
bm5lY2Vzc2FyeSBjaGFuZ2UgdG8gY29uZmlncy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsK
CnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMDE5MDYwOTExLjE0
NzkzMjktMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICg1KToKICB0
YXJnZXQvaGV4YWdvbjogYWNxdWlyZSBCUUwgYmVmb3JlIHJlYWRpbmcgaW50ZXJydXB0IHN0YXRl
CiAgdGFyZ2V0L2hleGFnb246IGNoZWNrIGV4Y2VwdGlvbl9pbmRleCBpbiBoYXNfd29yawogIHRh
cmdldC9oZXhhZ29uOiBkcm9wIGEgcGVuZGluZyBIQUxUIHdoZW4gcmVzdW1pbmcKICBody9pbnRj
OiBjaWFkIHNob3VsZCBmb3J3YXJkIGl0cyBtYXNrIHRvIGwydmljCiAgdGFyZ2V0L2hleGFnb246
IGVuYWJsZSBNVFRDRyBmb3Igc3lzdGVtIGVtdWxhdGlvbgoKIGluY2x1ZGUvaHcvaW50Yy9oZXgt
bDJ2aWMuaCAgICAgfCAxNCArKysrKysrKysrLS0tLQogaHcvaW50Yy9oZXgtbDJ2aWMuYyAgICAg
ICAgICAgICB8IDEwICsrKysrKystLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAg
fCAgNiArKysrLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgfCAgMSArCiB0YXJn
ZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0cy5jIHwgIDggKysrKystLS0KIHRhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5jICAgICAgfCAxNCArKysrKysrKystLS0tLQogNiBmaWxlcyBjaGFuZ2VkLCAz
NiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

