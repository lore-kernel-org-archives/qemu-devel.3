Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653C1CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bd-0003GE-7b; Fri, 29 May 2026 17:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5BY-0003Di-Oe
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5BW-0000Ky-LR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2HkE198956
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=DQBIVGYghjzyw90bMHrQCq4RL70HUwqTEiVHuIkHj+w=; b=LD
 Pzg2lIhPvE85IKKQSCt84/hNiRf0ZKWmnd3QE/FQzTgMjRJhCHQ1U0TGaVXOgENI
 lxbaDDzIT0PFEiB23Eq0SE1oIrYgO0JADrSazH+ImiEAQR2Z+tnWb5u6iw3VRpt1
 3qJKFuyb1ZEPm6J36ZrYblm09dDKiDixZfxk0Mppj9i5kf+r+a6Lwn/eVsyYBeNd
 yDTn6JAgxQlegYVRSu6cGxdrnORNGSad8kVjNQdhSEcRoPhL0j6yiek26vmSEtjb
 tIuUV0daur6DGGS+zj5tpkA0FSQmBBFrN5QM8TxOPSmd5MhFY6FxQTIl5TYCCla9
 FDwLz7/M2gWKJ8IDBZAg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnhxm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304f1820babso1363705eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091764; x=1780696564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQBIVGYghjzyw90bMHrQCq4RL70HUwqTEiVHuIkHj+w=;
 b=GBJXstuzGF5sLes/ekV99pk8BG2q4AE85peEkSH47tgy19GI2GYNxCbqesZlRuRDHI
 +xbfWtAyqndLIiiVu0CMoCJS0zVcyFNxRINcNiLZRHXU6M2I4gOiqgpLj+AGOgVMaBfm
 rRwvzCbecBJWpgCYwCkxWxkVIjIBpTmo7Isx6RjHreTxZm214ZWcQkqy7r/wfw9YAX01
 M31/ftciUB5p5vEpkgrltG7Gyg5oAU7AQ+5w9iLjy6Q19HRUlUkPD6biNTXWyNaVyPCN
 EL5cVi1Po3cYHRRUKNrchi4loLQ2HVOwjvKS6ejB6Oh3FLx2etMNg3mDpI8abrxhhbQN
 Hm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091764; x=1780696564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DQBIVGYghjzyw90bMHrQCq4RL70HUwqTEiVHuIkHj+w=;
 b=RIlPTEU1cJVZw+T4ycRxOEOaj03WM9WeGR6tnUukDQbCjtMqNqJpDO7/mAdfCfpcIL
 Ev3ypW5K6bS57G82qCHxzCPFG3HQ/AC4kJojgrD99tdI3ok6Wbb0FxsRGXYB3opIWeDk
 I1+8bxFclhoIaqtB0aWqQW/BjqZu39PHS9C3FRFtWsGYtMs/ie+LI5N0sJ4ATUnPafAj
 lDyNuHoz7I6bObbpg+qtQHJrxgu6zwgAb88yI2r6ZRLg5x7BsjKI+8q8KAEgcMv+Dv9g
 S+GzuctzKUq1FsnkTjVsCOC3KrRWXWsdakunm3/11zbi6HQO1NtWes7PSGy9KrKBgt1d
 Dp5w==
X-Gm-Message-State: AOJu0YzEysCZ8x03K6aiQumJyqiW/AWzvs14fiO31iWIKx6SU6ux6Gkd
 Pjc288h06ZtiaHayHoMcADFR7AavEqi4AlGlLDtEG93dV17ZQhUtxsymlPXM5RvNPuX3dIjJyX4
 efHPGzIXEezZrP0OAMQhGL+7yzqbLP/6ET4Xgkc++EhttdWRiX+5/aNOba4sDPJvd0w==
X-Gm-Gg: Acq92OGk5yF6pN56Q/NiCbEk9oF1q84kpTU0GSspuKijfxXBycDAi7EskohaNwagzaf
 mTRWysh+eSQ4lOgU3LKKQAUoXpKtTEwZEo1rHR+2fyvG2x33ck1QNpygVpPWkHP9pE78rjiqxzO
 0chdexx+hjOQIHxmdyvsdQxmijyp3B0iNJqJtjgQIokZwHfYaTfAQzERcrGDV5erPWSESkb17OA
 wHhmPPrqTtOvQfKKuFrQJLQ117wemOJ/gtgAel97hC6DvNSFh9mEEepzTwEaBoLz5iOw1kHQCQi
 CqVZ2O3HdfsFNIeeg0GitMwYp2siSqnwejS1AAf7Ojfhu1jk9pUoGDpfg8KM0bRRXu8K3NqUwCW
 EfGzL4wxuC8o1ic1UiQPB/C2GInl9BQ9N5AWnQFseib8rYZQ52zWnInj030BOFtzfYPN8F2v/s7
 hTZ95k
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr788626eec.31.1780091763678; 
 Fri, 29 May 2026 14:56:03 -0700 (PDT)
X-Received: by 2002:a05:7300:3b05:b0:304:df0e:9dba with SMTP id
 5a478bee46e88-304fa6a755cmr788614eec.31.1780091763158; 
 Fri, 29 May 2026 14:56:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 03/38] target/hexagon: Fix badva reference, delete CAUSE
Date: Fri, 29 May 2026 14:55:19 -0700
Message-Id: <20260529215554.606133-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX/z+9Vpe42dqM
 Ta79lxnsw9EK0cHk07klfNnnZfMk2PGMD7iFq6KscZmKQvuWQ7rGBMOGapom944vdKuHUxcF7xc
 NS7NeUMvEMG1u4m/KWIhpGG42Fq+6ZJd7nYvLj0lc9oXGlGA7AeCAhB+o3DcsIx7I2r6JYU1Bcw
 7VWg1Qj7mAx+bsYTzPOdKee/xjnVPFTF7yhbs2BJzmF9NquTxva8+4mq9Z7b+qtnn9mlYmzRh4/
 Vd+PdI4BIJtZxPNcBtxBE9pqjME7qT0hEbHe+Tw1CZYVR+GEunhdTT80Y5vOAU7mevDV2sLM/fp
 x+BPtXL0fhK+H1xVxawYm7ZZFIyc098pOGDPkihqLt+QtKvAdQ7Bewuies+PHf56b9BCz+/O1VD
 qUFDJWT1BXQ6dlVvDMuhuYS+8apW+IrQRL76R4tqQAj/T5Qnd97FUfThPwXWKvGRiyCs1gYGYR6
 97IbyOlXbkQFExYYd9Q==
X-Proofpoint-GUID: AHQgHPrJjgrXBgrkf7yZAqPE-f306SA3
X-Proofpoint-ORIG-GUID: AHQgHPrJjgrXBgrkf7yZAqPE-f306SA3
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a1a0b74 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDExICsrKysrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MmM1M2YyYzI4MzYuLmJkNTY4YmRkODcxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMTEwLDYgKzExMCwxNCBAQCBzdGF0aWMg
dm9pZCBwcmludF9yZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCByZWdudW0p
CiAgICAgICAgICAgICAgICAgIGhleGFnb25fcmVnbmFtZXNbcmVnbnVtXSwgdmFsdWUpOwogfQog
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIHByaW50X3Rfc3JlZyhGSUxF
ICpmLCBjb25zdCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkKK3sKKyAgICBxZW11
X2ZwcmludGYoZiwgIiAgJXMgPSAweCIgVEFSR0VUX0ZNVF9seCAiXG4iLAorICAgICAgICAgICAg
ICAgICBoZXhhZ29uX3NyZWduYW1lc1tyZWdudW1dLCBlbnYtPnRfc3JlZ1tyZWdudW1dKTsKK30K
KyNlbmRpZgorCiBzdGF0aWMgdm9pZCBwcmludF92cmVnKEZJTEUgKmYsIENQVUhleGFnb25TdGF0
ZSAqZW52LCBpbnQgcmVnbnVtLAogICAgICAgICAgICAgICAgICAgICAgICBib29sIHNraXBfaWZf
emVybykKIHsKQEAgLTIwOSw4ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BV
SGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFncykKICAgICBxZW11X2ZwcmludGYo
ZiwgIiAgY3MwID0gMHgwMDAwMDAwMFxuIik7CiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIGNzMSA9
IDB4MDAwMDAwMDBcbiIpOwogI2Vsc2UKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0NB
VVNFKTsKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0JBRFZBKTsKKyAgICBwcmludF90
X3NyZWcoZiwgZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVY
X1JFR19DUzApOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ1MxKTsKICNlbmRpZgot
LSAKMi4zNC4xCgo=

