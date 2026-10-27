Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F7606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NlW7K73c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TxI8rXWL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiJC-0007Ek-1z; Tue, 27 Oct 2026 10:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJ4-00071o-Iw
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJ1-00060m-GN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoJPl2948485
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=; b=NlW7K73c3xC8zqo4
 bsnAGbKA8oYLYArdG8o6cl0um7qN/PfyzeKYVrZEcyMigWJT2QNn1/c+GNnNjlsS
 eOz7TAF1KZrsIe81g3LXuhCEmtWYQ/4KYWPt92HiB3ox7DJGPKi+Qv7VYqd3lJcL
 nXTjPGZDS+pxj6iSK3FugUG0Bi5dAC1DkyqfN5+NUuTmbYbPoLWLdmOzKT9df0G2
 fhL3ge5HFP//b6nfqmG3g6f3SJKX5dLjIEN625BOgvKRK49aE0WgaKyBYgHK/szW
 H0GdIJOgisVHlBqhUjBxF/zYXUxz4Txi2S9AaYiJYT+NbRbwD4sgA9xxZBE86y6a
 ZK2dqg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw21kvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad53f538d2so3813328a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111857; x=1793716657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=;
 b=TxI8rXWLd3HPwrZWAdVuudtBg0ktskiu85qGy3ZdeE80JepF6sS9M56DGJ1vF4yUPV
 oHn0GtthDDZ7HI+Etshjv5xT3Ou5atFfwlMhFMJklzzIvKEw8R9p/JV5dQIaIxGuP+CU
 h347PULrTn8ub/uqDJqbkgN0zyOd6DUTGHD6Yrzqj0HxMQh7VBXPQECKnS07euSioNp0
 ecLocVHu5J1NdgaTlNsCBNH/LkQFlC8b17/b/fY3G/SWAJ3b/aJclEy1wwIJa1cydqv1
 InoP7S2ZIaGg9H+2g1jOvLO77tpSVnwO2ydPJYli/DzaM5HgPckx8hOFl1PNUuHti8e4
 VYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111857; x=1793716657;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=;
 b=xtp/Js4/NG8isyzl5TkHP2CqqXjNtrp2ANi9K/cuOIJxe6l4fE+5Ug6ciOC5LrYvrG
 skO9xH9QYmwSf9Mtr6bEgPyCTOGzg4pVSaaOByfOsswpqnLnHXR2H7q+cKms0I61i+2k
 V1YRgMzgVPPor/8h78NbriaOGuwNGBCuQktO0oX6yLAkhSaZrw629B3HBOwfaRNqBd+F
 KX4lXuBbFl1FQi9QrxVDMkEBHSwmxBA5VYk1pOnY71VXvLVB6DjrvTRY6PSJfTHj9B+u
 i5opUp+BzZcFcEsTDMmDfwdRJKFMa8FEs1sbQNFIooOdDhMHxyNp5W+s0Nzs2dEqAb4F
 WM0g==
X-Gm-Message-State: AFq9FYLAvBVHhh1m04uzDs8kkwSVSkUHrp8saweXqUn1bdthmGHlSQBi
 d/3BX8Wzw11Mei3onbOcCLySRZHEMRRh4flhAx7blVNR+pE6FRQO7jMnBa2GkFJNW8u4YQESL6I
 gw4f4zfg0E9H9gvt2d2b+SOyduPBwEkmLrvCVcKHKsyz0jB+gIF2LtftrBevwbOfrdA==
X-Gm-Gg: AYBFou2MGqGpWRYTvaVufSHC5HCxTCsAOJgKAAgEicbgVN4FfdETt7kRUf7UE0PkdkJ
 b0p+P6wdv7RMrub0Y5ie0G/Jpi5NUTYUQInKdCS7D31xIra3QiTtL4orjerSPSMM4UeIyGadPzA
 2pyy8WmgT11R+YOnyf5UhGaGXsemCTGjk6zpva3nYR+rX3RYwu1312qVc4YpmKBT/+J3i/CiTdC
 PLHcKJHZmLpck+UxbwTQMQiphwZz5ZQyyJpGXiv94K+bU04JPI8i5QdkOKA1CmXng9hpkfRHUv1
 uOQpd4XmWIHjphnE391ZrHirpDoqkbBKf+uuKY0KZlzGNR6gn2mgSZNcJT2cYNmteSZd0paOHxU
 EN3tO/8k8bxWueeMRfoI+U0N2Vn7ur9CMNQu/tGhNxURTmVA=
X-Received: by 2002:a17:90b:4c42:b0:3a8:de1:db07 with SMTP id
 98e67ed59e1d1-3ade9b2f72bmr8112560a91.5.1793111856917; 
 Tue, 27 Oct 2026 07:37:36 -0700 (PDT)
X-Received: by 2002:a17:90b:4c42:b0:3a8:de1:db07 with SMTP id
 98e67ed59e1d1-3ade9b2f72bmr8112529a91.5.1793111856156; 
 Tue, 27 Oct 2026 07:37:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:37:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL v4 04/42] target/hexagon: sort tag_rev_info entries by version
Date: Tue, 27 Oct 2026 07:36:43 -0700
Message-Id: <20261027143721.4125584-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX0ZyYkedPNxN5
 b1cinyy+qkoO6EDUya0DLpWQBJ4VcrkQBWpMHajQ3k409yvcOaUFESghd16sl7y9XD/sNHBMJHK
 nwImyn63Ker6uhvSLvVT0+EOetiL1KJcXsnQrjHDhgRJjr2eRgUBoXka8zdHlhEgf0Xs8D8JjBB
 fhwXOYhjxIcg3h2MRegpSW47M2rMaqrDNR52u7PZ4Ql/v+cmic02yR7y6tPf4aXMqpQDnSUOkjz
 FNu4pzikGajBqCT07UkeEMFzriDZisGbU7mwr3X0Z87Yr/M/sh0sNSnV+ufcsBBJJZR+V3wrxGq
 TdndlN8htMCDl45RUfX2Tfrjotpydq/K+PKUYmmmhmuNXsGWNkyyooHpA7PkCmLhKrek6ZxY4P+
 QycVRGgbwi588aLTVc33zbIwkTyRMt3/7xh775g4GgccGcrgBxzgC6rhwE/5zbK3kz3Db4+SR49
 VCD+raCr7LFL7dtfxVw==
X-Proofpoint-GUID: vnN6Zk-kdko7bX1jaC35qU_pqXI4wQL7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXzYiJyNnB/BQK
 EAx/nEaOrosKaYeediNvOwptw154XcpoxOvCaUOIFF58YTAA+uuUrhqdG4h+cHipRTl/IEZVLbW
 l0tL4YsAss2gRvKL7ja7fV6kTbjgvw0=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0b732 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XH382VzwAMdzo9DkozgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vnN6Zk-kdko7bX1jaC35qU_pqXI4wQL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

VGhlIFY3OSBRRmxvYXQgZW50cmllcyB3ZXJlIHBsYWNlZCBhZnRlciB0aGUgVjgxIGVudHJpZXMu
ICBNb3ZlIHRoZW0KYmVmb3JlIHRoZSBWODEgYmxvY2ssIGFuZCBncm91cCBWNl92Y29udl9iZl9x
ZjMyIHdpdGggdGhlIG90aGVyIFY4MQplbnRyaWVzLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYyB8IDMyICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMgYi90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKaW5kZXggNDFj
ZTNjYjU3MmYuLmIzODBhNmI0NGFlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCkBAIC02
NDMsMjEgKzY0Myw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZf
aW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAgW1kyX2RjZmV0Y2hib19udF0gPSB7IC5pbnRy
b2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1ky
X2RjemVyb2FfbnRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhF
WF9WRVJfTk9ORSB9LAogCi0gICAgW1kyX3RsYnBwXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVS
X1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLQotICAgIFtWNl92YWxpZ240XSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAg
ICBbVjZfdmVxaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhF
WF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFoZl9hbmRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9W
RVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFoZl9vcl0gPSB7
IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCi0g
ICAgW1Y2X3ZlcWhmX3hvcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCi0gICAgW1Y2X3ZlcXNmXSA9IHsgLmludHJvZHVjZWQgPSBIRVhf
VkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmVxc2ZfYW5kXSA9
IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwK
LSAgICBbVjZfdmVxc2Zfb3JdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFzZl94b3JdID0geyAuaW50cm9kdWNlZCA9
IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92Y29udl9o
X2hmX3JuZF0gPSB7Ci0gICAgICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FCi0gICAgfSwKLQogICAgIFtWNl9nZXRfcWZleHRdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtWNl9n
ZXRfcWZleHRfb3JhY2NdID0gewogICAgICAgICAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQpAQCAtNjcxLDcgKzY1Niw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZfaW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAg
ICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FCiAg
ICAgfSwKICAgICBbVjZfdmFic19xZjMyX3NmXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmNvbnZfYmZfcWYzMl0gPSB7
IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAg
ICAgW1Y2X3Zjb252X3FmMTZfaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVt
b3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtWNl92Y29udl9xZjE2X3FmMTZdID0gewogICAg
ICAgICAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQpA
QCAtNjk4LDYgKzY4MiwyMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRhZ19yZXZfaW5mbyB0YWdf
cmV2X2luZm9bWFhfTEFTVF9PUENPREVdID0gewogICAgIFtWNl92bmVnX3FmMzJfc2ZdID0geyAu
aW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAg
IFtWNl92c3ViX2hmX21peF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1Y2X3ZzdWJfc2ZfbWl4XSA9IHsgLmludHJvZHVjZWQg
PSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKworICAgIFtZMl90bGJw
cF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05F
IH0sCisKKyAgICBbVjZfdmFsaWduNF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5y
ZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcWhmXSA9IHsgLmludHJvZHVjZWQg
PSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZfdmVxaGZf
YW5kXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05P
TkUgfSwKKyAgICBbVjZfdmVxaGZfb3JdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92ZXFoZl94b3JdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92
ZXFzZl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9O
T05FIH0sCisgICAgW1Y2X3ZlcXNmX2FuZF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEs
IC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcXNmX29yXSA9IHsgLmludHJv
ZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZf
dmVxc2ZfeG9yXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhf
VkVSX05PTkUgfSwKKyAgICBbVjZfdmNvbnZfaF9oZl9ybmRdID0geworICAgICAgICAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQorICAgIH0sCisgICAg
W1Y2X3Zjb252X2JmX3FmMzJdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAogfTsKIAogI2VuZGlmIC8qIEhFWEFHT05fVEFHX0FSQ0hfVEFC
TEVfSCAqLwotLSAKMi4zNC4xCgo=

