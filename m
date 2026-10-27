Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E30606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZYtU6sB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KHcbH/gq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXu1-0004mz-Ro; Mon, 26 Oct 2026 23:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXte-0003tt-8l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtc-0000B0-En
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F1ao1919987
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=; b=nZYtU6sBC65MxkBp
 2HMKxBvvdPxm3HB9Zv1GIuRxkwv03nhFrMxqlvamRoxNtSEVnXXFa4HptKFbsJq+
 eYQTbi7UpvobVRjY3BQhNPhn3PnBryoaN/B4+tX1+3pGE1XKXeCfRg4xRyhhj38Z
 0xJ+hrh2gSKLhhY3GDBN1IL7g8DMJBWi7R8ejImkCBe+eA9PjUXPIslTfzR9QPEi
 YqTFU/jBQfoVvDxZxN+sKoaDdyAbnKkEmDw2bfqhtU3Z8pUstfLthdxWkc1n+GQH
 rHt1ffWxsbCjuszra+mn6AV4OYVP7gesHWLXbGT3sEvdccPbGb2J5iZGpeOY2Yq2
 dok7Dg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh918hcm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:42 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-15c16792146so1110202c88.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071842; x=1793676642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=KHcbH/gqTqO5uW9RPlFSX0rfzwmhHCImrFgfnssZPYJsOt9M8ZxQgSqMSCCheGBYjN
 4MjDSY3K/PbXY6LFOScjGiQsFkVHqhyNrj0ChlCArsMYhG5P9KVUd6W0UN/1HBBIa6sz
 VXpzUmvEOaQRlkNcpKTlm+7CquxCJLg+d1NZ8RTJ7TIbR05bWQTMYcReSx8wuENLwGQY
 2LA1R39McV/ViIKYnnx/Ewhlpzd6sI/e9/xBtB7qk4qhEJTgGp+VWxqerd5vNQjKTQg5
 j7ByZtATMI4ieHpuTr/C/QImnP11UGf1EtNmfoMMpT+FFJFiR3ifIAjxnlmO3p2eHSzp
 hshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071842; x=1793676642;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RDd+3W7W0y2S1eg7UzvigTldH4Gn2gC+LnwBE714ODw=;
 b=Ncvgv+1ynApU6ZlpZfoeTsVmkC2dAReGA7T2YZ1AFf7k65f5vjhhGFc0xIO7hNNqE2
 8hCA6y9pH7cH9Y9CNa03ntWUoc+xDiDg3caNF/92KzvDuCfBh6jxnux8HVo0ymc69U+E
 hT5/cwVcmNwRWNzcxdhb5xoahS9+dABSzHnitZHkp6rqTi8rHMAYGVDvMWwE0otvHIhN
 cKptjOSYL9+A0VN7FYuZ/Z1v3s5+5SlW8DtjIav3J3U0oDibAL7OqCxwfxDYrv1Mb59H
 QfdGBMdrKw3YQHDAHkyfTW6WVBT7/kv/EnyaFliRh0+6I2sUBXXjTW8PEHXRn+0ez4Bo
 4Rfg==
X-Gm-Message-State: AFq9FYIe4YwZSbY8l4hH+YGeclHk5s0FQySvLcHEi1pt3+bU9oMY2OIx
 xEQl4X64aiz8aPWCq7p6GkIht6xQUcBTUeF39/8eOgj2enap7m4gp3hIEZhhHDlEyqurZ4yRYSs
 39Bn61csL352/bEn16BUsArFyV9R0SrVdhqjWMZnMSSi1HJ23qOaNHurgb69Vnp11zQ==
X-Gm-Gg: AYBFou0IwHAxcWF7onHmdzvYe9MsmJe6pZ74kXU9IOGlXbk3Fl9woZ6OtJb8ZFeXuXx
 po+0e4jjM4HGOfrFcECUsKvKfdT8XKQ5ox1RkNkFM0mt5p8StOcKmSOvnd9MESeqGaNrthzEkic
 DbcHxG7KODlSpmwAluucnW0ZjSs9avfoI1shTEs/67eR0PypSH5e/C5nChDRMBKv0wYjqjXYhcQ
 vliMP48iqJaMFCOk0fVrtw4pR7flw2QR5tkYzN1BxoDAN2zqSsgzI4Rm7AgpWj9w4ElHCdIQ44h
 cccs3PufRNC0XAQ/HuzFdOsZRNMh6xKGHohTj0gjSZXf4TgFcrMkpK+HGcw2EGM2j1hLMzDfolc
 KZOs1ccs92NR3NwRtgKxhd9MMClp0yvXAP52HXXsknSERW+k=
X-Received: by 2002:a05:7022:1509:b0:16c:3408:760b with SMTP id
 a92af1059eb24-19937306c70mr12880076c88.32.1793071840201; 
 Mon, 26 Oct 2026 20:30:40 -0700 (PDT)
X-Received: by 2002:a05:7022:1509:b0:16c:3408:760b with SMTP id
 a92af1059eb24-19937306c70mr12880013c88.32.1793071839102; 
 Mon, 26 Oct 2026 20:30:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 32/41] target/hexagon: acquire BQL before reading interrupt
 state
Date: Mon, 26 Oct 2026 20:29:18 -0700
Message-Id: <20261027032927.3055166-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: VNUzHCdPygvGJHavBEjVURgnzR9JyCRn
X-Proofpoint-GUID: VNUzHCdPygvGJHavBEjVURgnzR9JyCRn
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae01ae2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=52E-7OzoYlKJP0MoAcQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX8F5kz/jJn8U4
 ARv2gfao0ryDk0LAoJM5lP4fhb1/R/3OzlLAuNmQts0C45tGRDYBokYBKphv5SGFHDn0Ey3Gygs
 qGE3xeWJjH+KXY7oYoC0VdYw7Nruk07Y0m2NJt5DtTgGd9zIabwbQBl2ajxOPkzEBJbr/+3Len4
 BSw3CehW56nWnPxERWrdTXgnC42gva1ITzSBvZtUGWqvGL/+tR5P807pcL8A1Jf6lvGcxo8BRNX
 eLv4ZXtJXbKtOupO/LIV2IxfIsPgoo4AlbS8+feDVkDEqkqwIB5NFHmw6p8HkRjTjTK7HnM28W4
 Oxc9OuDGlJ1nrRTaI0m+AITIrPHu+G6AkvYT5pVGqmb9cXqwtyNuR4HOkx78JLK39oprs4L2c0p
 6DbK+7+S5Om9o1IahBanAZBV71HtMUF0tzBQUIAemjBT7iJIdXOyIfH9SYRb6xw163VzrmOoEZv
 eMYzc1w5pcBoCN/3OpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX/G47ZuyN3T2C
 cfDClw8VFduAL7bYwRN4P7qIlIQ+HsLUAWD0akcVETRetjV1WcqOsPfNzJoKkqethMQjT9y9sPd
 LMSHSEZ5oY8wYG7rdkKQ3nnBE00AoUk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TW92ZSBCUUxfTE9DS19HVUFSRCgpIHRvIHRoZSB0b3Agb2YgaGV4X2NoZWNrX2ludGVycnVwdHMu
CgpUaGVyZSB3YXMgYSByYWNlIHdpdGggaGV4X2ludGVycnVwdF91cGRhdGUgb24gb3RoZXIgdkNQ
VSB0aHJlYWRzIHdoZW4KZW5hYmxpbmcgTVRUQ0cuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaGV4X2ludGVycnVwdHMuYyB8IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X2ludGVycnVwdHMuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKaW5kZXggODFl
N2QwMTZjM2QuLmI1YTg3MmRiOTg5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50
ZXJydXB0cy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKQEAgLTM4OSwx
NyArMzg5LDE5IEBAIGJvb2wgaGV4X2NoZWNrX2ludGVycnVwdHMoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgIGJvb2wgaW50X2hh
bmRsZWQgPSBmYWxzZTsKLSAgICBib29sIHNzcl9leCA9IGdldF9zc3JfZXgoZW52KTsKKyAgICBi
b29sIHNzcl9leDsKICAgICBpbnQgbWF4X2ludHMgPSAzMjsKICAgICBib29sIHNjaGVkY2ZnZW47
CiAKKyAgICBCUUxfTE9DS19HVUFSRCgpOworCisgICAgc3NyX2V4ID0gZ2V0X3Nzcl9leChlbnYp
OworCiAgICAgLyogRWFybHkgZXhpdCBpZiBub3RoaW5nIHBlbmRpbmcgKi8KICAgICBpZiAoZ2V0
X2lwZW5kKGVudikgPT0gMCkgewogICAgICAgICByZXN0b3JlX3N0YXRlKGVudiwgZmFsc2UpOwog
ICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQotCi0gICAgQlFMX0xPQ0tfR1VBUkQoKTsKICAg
ICAvKiBPbmx5IGNoZWNrIHByaW9yaXRpZXMgd2hlbiBzY2hlZGNmZ2VuIGlzIHNldCAqLwogICAg
IHNjaGVkY2ZnZW4gPSBnZXRfc2NoZWRjZmdlbihlbnYpOwogICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgbWF4X2ludHM7IGkrKykgewotLSAKMi4zNC4xCgo=

