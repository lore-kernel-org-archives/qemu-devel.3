Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C284EEA8114
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnsv-0005fe-CQ; Tue, 10 Feb 2026 08:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vpnsn-0005dz-04
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:34:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vpnsj-0001mr-NR
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:34:24 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AAQMxZ1940437
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KlxvotwJGugCYYVUhE6iu/
 1yh9rGWdS80COE/20q904=; b=lWs+kCa+CO3xPgZKMuellJXjwvrVTem1X0Aieu
 XO2SXXr+MDle7QpHRYpvQwDJNnikl6TqL+Ai1kXmPX/dijH98dhoSxJNQmOdRsiR
 tCzdl44io6DQhHsthaFMFw9YLzC+/p9ctrJKpA8HBFibhnq+P5RSQX8djZKG2V4M
 wYANkCPyeC8c26kyXlfdnRRL9Dbir39Os0i86AcodlvaL45N1QRhRrgMaYsEFLfS
 6M+VLAWMeH73W4Gh5VCaHpWmcXefa3YV0KLJE/mQb42ZJj8NinmRUh0N7CPG+RSQ
 uJuXpt8au8KRifutG6Xxuvz3r7eDCJdIQIdbTf1D7yg9yq1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7w1jsq6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:34:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b6b9c1249fso4503510eec.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770730457; x=1771335257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KlxvotwJGugCYYVUhE6iu/1yh9rGWdS80COE/20q904=;
 b=ClUDK8At2fh3jVElknjLy2sALJ8dPxD0/UFveo3cP+PQYiqYv657nOU6Zcc5RI/sPn
 VmX8nq3XIpkYXvH58QW4/uawio38zB4HVmuH1fwbKyns0CMiAIhfR/IZAryAD1UGo0TI
 CSuFFs5nWNVyxVv/vctk/DfYzLiKwXqW3nvQaf4O8TTaQpx7KqsnutFgAhkDmGduyyMv
 AE+/3NIwSJko3Po7/fvZWK3rexE2fp71uFEOBHvBuOekC7y3JG6g2ptNcF6Snl25QERn
 /fPQcC8Zm1cGw2DcoG9MlHJvzth5rpsFOOtu/Fsw4HiWmwsiC7bHsRL+RdJE2/hVpjTL
 540g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770730457; x=1771335257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlxvotwJGugCYYVUhE6iu/1yh9rGWdS80COE/20q904=;
 b=UhczQiK6BVoryBarosAfcUf346UtRsdTD0t1QXnUKo10O2HUcup1zDTjTy2QlNWxNk
 5dziWm6EJhJQRC6aUlveoOVPtqRXTvJoS1AsmAAxRlfbzWxgvyR86K+aAEUwFWwX3hT1
 cATZSbtEYBbmU4xD1gZqD2Ahl4YpvL3m2v252mEJw9ZC8xWStNxKppe7xNkChFc0i5z2
 Rjyf8DNfK4QbKsFo7lYxqI/7tmccjbgXPIEK+KNqE6B2Mx9Cjv300X/J5fm2f2qoRPfb
 wAlgwJGAEPjK0ZRiIEE1HpLurUMHixGTb7ubC7Mh6Y7XTmSOsinIWEawFHlTDWFqCv6E
 W/Fg==
X-Gm-Message-State: AOJu0YyYmUXlyLzBu1pHSfqI62YFcFHw2cvychfLACMrZZZq55Wnu+VW
 FcJb1vvmNXyhdtbquv1JggRfHzJKeOkbrCVyYaf2G8mnx1STYow3xUr/lMxlzLC4pEw6BxqzUrU
 6fE8Q9uemdJUJHuliS5yqC/k6kIIvf/UyuFtcTQHlo7QU3sDIbaoMXSL5kJZO1+aDVA==
X-Gm-Gg: AZuq6aJffBMCp33MpwfHBkiSFlnR6LVyhiXMYpAjhXeuOjOobH3bOAoBscuY5FYfy0A
 5yguFCDtz1jzLhZXmRSkKWoabYCTE3NQ9OpQL3GjWGKKtt8nVnMi2NOIjrMEnoTXC9Exn3aLJxj
 sWi5QX8g1LZkF4CrG4flEoIBrVP4zjy8F680GhxwLUBiEhdhOufxQJOOBYHaGT9pSBZe2riQcpt
 6CSCWlffQVYQDEAYFDKwYjsiOfrEASvCZ6SDyLO+WJuZlTG51tdew/FlsAPBC/aOs1CUPDYComm
 VrFttm5Cx30wYUQzOtAtOTC6FRPboBqvRV5yNdKwh77BmNBXhUDImECvNwZVKd5OQKu0EpM5GcV
 vzNvqucTLpUJ2nJj/tYTSrVFCXVr85UK972KiYwKwblQA6xUkT9VSfSRdrSVXllB2ImWKpQ==
X-Received: by 2002:a05:7300:572c:b0:2ae:55f0:f2be with SMTP id
 5a478bee46e88-2b85683e423mr6838554eec.31.1770730456503; 
 Tue, 10 Feb 2026 05:34:16 -0800 (PST)
X-Received: by 2002:a05:7300:572c:b0:2ae:55f0:f2be with SMTP id
 5a478bee46e88-2b85683e423mr6838542eec.31.1770730455926; 
 Tue, 10 Feb 2026 05:34:15 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba7e149c58sm2716162eec.26.2026.02.10.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:34:15 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH v3 0/4] Handle some invalid encodings
Date: Tue, 10 Feb 2026 05:33:50 -0800
Message-Id: <20260210133355.16093-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: J3VYMkr2j9P1wHY6SJ6XG3h4EHTg203h
X-Proofpoint-ORIG-GUID: J3VYMkr2j9P1wHY6SJ6XG3h4EHTg203h
X-Authority-Analysis: v=2.4 cv=YrIChoYX c=1 sm=1 tr=0 ts=698b33d9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=7OUETykng6pzQwdykssA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNCBTYWx0ZWRfX3peXTGbIzHfe
 7rWWTQ+RR59Mli4y7Nc2Ff3TrL/NbWjnvY14oDR7jh3bFfUY21Yb5X4Jv883fycQvMvAkgAxJ71
 M/g4dW81xMv1hOOvjRjh0cMmhNCD6vSbQfcWOzMAZvB0Ab7DED3B5MGGtNPnmscFH+YzBjeuMuB
 KIxscUAh46I6bMV/a2aShTyMu0aGujJlaHrWslEUDypnl8juRMl0kBPQvRb7iRXnyWR8YHPkagH
 FmZ9fA3vOslhWko9d0NDQLCjCJbwbEAJHJnKUurU0Ili9bC81Fxxixj5KinWxNFx73kBP763hXZ
 oPfSfyZ9ZkF+n1IP9OvfK+LjLYZGYGlAQRTEIIx/9Lbkevx1eX+owM+M28vsi9vb+urDr8QV5or
 78d2MV+7ZqMZnyQ/vO53QzUy3P2G+qr8VuUhSCyETE2aOqbrjoVMmv/OnNtOcR+XxsBIcuswAZB
 IUH1RHuRlXdKGkLp+zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rml4IHRoZSBpc3N1ZXMgcmVwb3J0ZWQgYnkgQWxleCBSw7hubmUgUGV0ZXJzZW4gY2F1c2luZyB6
aWcgdGVzdCBzdWl0ZQpmYWlsdXJlcy4gIFRoZSAweDAgY2FzZSBpcyBhIGNvbmZsaWN0aW5nICJt
dWx0aXBsZSByZWdpc3RlciB3cml0ZSIgLSB0aGUKaGFuZGxlciBoZXJlIHdpbGwgY292ZXIgZHVw
bGV4ZXMgYnV0IG5vdCB0aGUgbW9yZSBnZW5lcmFsIGNhc2Ugb2YgbXVsdGlwbGUKcmVnaXN0ZXIg
d3JpdGVzLiAgSSdsbCBpbmNsdWRlIHRoYXQgaW4gYSBzdWJzZXF1ZW50IHBhdGNoc2V0LgoKdjI6
IHVzZSBhIHNpZ25hbCBoYW5kbGVyIGZvciBTSUdJTEwsIGNvbWJpbmUgdGhlIHRlc3RzLiAgUy1i
IFBpZXJyaWNrLgoKdjM6CiAgRHJvcHBlZCAiUmVqZWN0IGR1cGxleCBlbmNvZGluZ3MiIGFuZCBh
ZGRlZCAiRGV0ZWN0IHJlZ2lzdGVyIHdyaXRlCiAgY29uZmxpY3RzLi4uIiAtPiBtb3JlIGdlbmVy
YWwgYWxnbyBTLWIgVGF5bG9yLiAgVGhpcyBwYXRjaCBtb3ZlZCBvdmVyIHRoZQogIHRlc3RfemVy
bygpIGNhc2UgY292ZXJpbmcgdGhlIHNhbWUgMHgwMDAwMDAwMCBpbnN0IGVuY29kaW5nIFItYiBB
bGV4LgoKQnJpYW4gQ2FpbiAoNCk6CiAgdGFyZ2V0L2hleGFnb246IEZpeCBpbnZhbGlkIGR1cGxl
eCBkZWNvZGluZwogIHRhcmdldC9oZXhhZ29uOiBSZXR1cm4gZGVjb2RlIGZhaWx1cmUgZm9yIGlu
dmFsaWQgbm9uLWR1cGxleCBlbmNvZGluZ3MKICB0ZXN0cy90Y2cvaGV4YWdvbjogSGFuZGxlIFNJ
R0lMTCBpbnRlcm5hbGx5IGluIGludmFsaWQtc2xvdHMgdGVzdAogIHRhcmdldC9oZXhhZ29uOiBE
ZXRlY3QgcmVnaXN0ZXIgd3JpdGUgY29uZmxpY3RzIHdpdGggYml0bWFwIGFsZ29yaXRobQoKIHRh
cmdldC9oZXhhZ29uL2NwdV9iaXRzLmggICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdv
bi9pbnNuLmggICAgICAgICAgICAgICAgfCAgIDYgKwogbGludXgtdXNlci9oZXhhZ29uL2NwdV9s
b29wLmMgICAgICAgIHwgICA1ICsKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAg
ICB8ICA1OSArKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAg
fCAgMzkgKysrKysrLQogdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jIHwgMTA2
ICsrKysrKysrKysrKysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLXNsb3RzLmMgICAg
fCAgNzYgKysrKysrKysrLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYyAg
fCAxNjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5fdHJh
bnNfZnVuY3MucHkgICAgfCAgMTAgKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdl
dCAgICB8ICAgOCArLQogMTAgZmlsZXMgY2hhbmdlZCwgNDQ5IGluc2VydGlvbnMoKyksIDMwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQt
ZW5jb2RpbmcuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxl
LXdyaXRlcy5jCgotLSAKMi4zNC4xCgo=

