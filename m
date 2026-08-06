Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C13BC55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmr-0002CE-46; Thu, 06 Aug 2026 00:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmW-00028j-93
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmU-00046L-MW
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763wqRr482374
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AcHGNCDebCbowTTEdPwquByXSx6ozOh5OPsSYRLG/l0=; b=KlR6U6919kCZLvcd
 vBR6nrDFYUDscDQUhIGLpGu5xJB0okJjjAxCeYm1R0RyTMq7IhuQJkgDAG0/nVR4
 daux8fsrTyuUgkXX2X/jCykorRhxqGDbwe1jEOJg2UfVjqx089vMAh92BotPjZjK
 pKRMnKOsDuxi9fdS0XonG8OIeU51hHgQK6GedWrGVOuUY7c7KzdPN3vqGw3j1D29
 Iz9syuic9c9AZxAvtcF6iYJbsF8tX9D0VnnvOUbgETEXBkbIK+ePYTpOIaEwXmfT
 orZn79FzZzhGRPWoxohCYeo4F/LJPW8cKC2XAo87MkCQdIDxIUt2ByiD+6HNN3dH
 LSapDQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjueg3aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbe62e01567so1558093a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990753; x=1786595553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AcHGNCDebCbowTTEdPwquByXSx6ozOh5OPsSYRLG/l0=;
 b=bIvR05Fm0a4kF5udabdaEld4SjMQliJqb5Nl2jTk7FvuVlBmBCBN7TX/7JGnxZ59Ev
 tdIZdqFVmInYhkOFNQbpf512UHb8UCc8R++PR2YdY0jE6NVdVhPeiv+J1QggT2urzTSg
 OHLt/9UcgThhhr/2aEFQ7TnmPe4HdlwwmWzLNA3M2lqmjkuBoQyvbp7k6RVVKvJJjx6w
 mM3iJ3sBQT9wB7XvhyuZY0V6PgL7qzO48let5R9kM3KAuS41zQAk/HZ2BN52bWDxfCNj
 NfYFsq//qR6GOfdstXzSjJj1GTC3odaDC/FoYZQ3c8htQqXHRYWwPQ6GBL01yqyvjug1
 2yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990753; x=1786595553;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AcHGNCDebCbowTTEdPwquByXSx6ozOh5OPsSYRLG/l0=;
 b=T+jkU2Kwg85pksD883TEFRyehwih1lDJZCKI26Bbv+7iYjwp3toChYelL2nEFHyoS/
 AHq/3EpPK6crE+53Yfx5SrsdgEx+5XoU1rqk4BneURQziKvUezLw2UENXy06AO/DUW+/
 2fjNKt+xGRUeNQ6+gAwgMTyWfovo6iNy11WBT2ERIDrb+fTf7qAUpMOP9iw1VNzgwgEW
 Jt9tzQAP+iMt792Gs1QOYvXRAcAXcu71W4cnSXEGq6I6egEnXeRgTX3CIjCytP1xLpYB
 Hz14Ey3Sk6Y2C1IU2XSfnlzOC2bhKnOgizmMrkEJCH6ZH7Dvsl9w3javkIg7R9/luV5b
 gAHQ==
X-Gm-Message-State: AOJu0YyzIDg/EeeOhZbX59umMDTYPVef7VY02ZWAaFkW8UY54EM/RoZm
 QXDdSZzd4u1iDbf8xPDhfWvWj1qLFwHMUHvXIfC2xBxuOCEaZqsAj+xxF4SGCimootpg2Hb1Mvw
 IjONjLM5MJ1CpZiIBzmRFVposEnptDBraXrt51iHJEHxC2JQT/6WkoeHksNjfMobOxw==
X-Gm-Gg: AR+sD10izWA41+G2sIq6KtxsrZL1fiID3OV52bWUgftME68jWxEI+/bZqvM8AZ++lJn
 WQ6ISJLUQDSC0hyoSsKhKD/tDgKxas7lTsGUiVooQvvcr9oeMzRNMk1qT1qovGCvTLKfdSFOaSg
 714AsT4Jb3vx5O8g+rMYoTfQCDEx2VNDyRm8Zj9k3Vr+7aTMMVCn585QKkYERw4imSRnQxnFwHt
 K3XqSCj66Wwdm9vezHIeC7S8zfP/zkLezPe3+BYOKfb0sbIXO2kzuFXtGfkm8pg9hMYFLXZLRcX
 euKht6sdNv8Dk/AMTj8v7BZSg4mDxvCRh+BHK4FdVWhZf88i52t6l2LtKHsq0ql9LybTOltvNv7
 H4cCF+004uLaQvLTq6SP0gOXwJm69gLEonKYnL8xtK8ONV77b
X-Received: by 2002:a05:6a21:329b:b0:3c0:b766:751b with SMTP id
 adf61e73a8af0-3cb85e991f7mr12918129637.14.1785990752633; 
 Wed, 05 Aug 2026 21:32:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:329b:b0:3c0:b766:751b with SMTP id
 adf61e73a8af0-3cb85e991f7mr12918083637.14.1785990752101; 
 Wed, 05 Aug 2026 21:32:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org
Subject: [PATCH v2 5/6] target/hexagon: add GVec overrides for HVX vector
 average
Date: Wed,  5 Aug 2026 21:32:22 -0700
Message-Id: <20260806043223.3787083-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a740e61 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5fOnMlAeMDB701wdRugA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: n5IKwJKjAqFClt4dAwWFO1XK-HyepfDi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX5gMurBn7tEWm
 Js+uqVnnbz0p0c7qt25zY//QN1OMq9q6PW1YlLb8qN27MW2yMr1z/w/H8hGDCN/8Np09qA8sZcd
 H0VOnE9x1c78JWqvkYLBo5edylx1b6Yjr3W079esZtATYzLC6/afKmOusrb/MYtcxcf1dq7H3r4
 TbqJB1Z9v0KXv9fhHCS4U0Mz2w9HiM5f6mXuRNoLD76PdveBuJVoWEQ580tPw/gTx0vg4Rz0MFX
 Jd/2/RzxjZ/WXUzuq1qUdU6uhetNPzyRh1uvA0K693is808EOX/eVm9PNRHXzFbDsYT4kQYBRI6
 OgzaFNPeMKer/wzqcz8XOVk5alXogZ+8q4tiGJ8WSDUistIc2852pXec0Hf31UEtrWMlp8qkbko
 5Qr0ucSo6i6rW+NNAUipdahxQupB57Ry1XEN4GbRt6lSUlwYg6B9SxD1ApPCg2szP0kiEzkafa2
 XchPmLsYSUFN8ik9K9Q==
X-Proofpoint-ORIG-GUID: n5IKwJKjAqFClt4dAwWFO1XK-HyepfDi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfXw2CsS6kgZHAi
 tDKuhJuEmNHUyJ7OQbNMlaV0ghJKZri9aveV/jvzCW4YV/h3cRJja1vP0dzc4THRP43M4DvgRQe
 wmEtkHipunZUBMuK4PPic+hBOcxtvn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060031
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgNjIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnX2h2eC5oCmluZGV4IDNjYjUyYzc2MWFlLi45N2MzNzNjMTBiZiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNn
X2h2eC5oCkBAIC0zNTUsNiArMzU1LDY4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhp
c3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogI2RlZmluZSBmR0VOX1RDR19WNl92YWJzZGlmZnco
U0hPUlRDT0RFKSBcCiAgICAgZkdFTl9UQ0dfVkVDX0FCU0RJRkYoTU9fMzIsIHRjZ19nZW5fZ3Zl
Y19zbWF4LCB0Y2dfZ2VuX2d2ZWNfc21pbikKIAorI2RlZmluZSBmR0VOX1RDR19WRUNfQVZHKFZF
Q0UsIFNISUZUX0ZOKSBcCisgICAgZG8geyBcCisgICAgICAgIGludHB0cl90IHRtcG9mZiA9IG9m
ZnNldG9mKENQVUhleGFnb25TdGF0ZSwgdnRtcCk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjX2Fu
ZChNT182NCwgdG1wb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAg
ICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgdGNn
X2dlbl9ndmVjX3hvcihNT182NCwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAg
ICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpOyBc
CisgICAgICAgIFNISUZUX0ZOKFZFQ0UsIFZkVl9vZmYsIFZkVl9vZmYsIDEsIFwKKyAgICAgICAg
ICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAg
dGNnX2dlbl9ndmVjX2FkZChWRUNFLCBWZFZfb2ZmLCB0bXBvZmYsIFZkVl9vZmYsIFwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKTsg
XAorICAgIH0gd2hpbGUgKDApCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3ViKFNIT1JUQ09E
RSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fOCwgdGNnX2dlbl9ndmVjX3NocmkpCisKKyNk
ZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3VoKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19B
VkcoTU9fMTYsIHRjZ19nZW5fZ3ZlY19zaHJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmd1
dyhTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19WRUNfQVZHKE1PXzMyLCB0Y2dfZ2VuX2d2ZWNf
c2hyaSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YXZnYihTSE9SVENPREUpIFwKKyAgICBmR0VO
X1RDR19WRUNfQVZHKE1PXzgsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENH
X1Y2X3ZhdmdoKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fMTYsIHRjZ19n
ZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmd3KFNIT1JUQ09ERSkgXAor
ICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5l
IGZHRU5fVENHX1ZFQ19BVkdSTkQoVkVDRSwgU0hJRlRfRk4pIFwKKyAgICBkbyB7IFwKKyAgICAg
ICAgaW50cHRyX3QgdG1wb2ZmID0gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB2dG1wKTsgXAor
ICAgICAgICB0Y2dfZ2VuX2d2ZWNfb3IoTU9fNjQsIHRtcG9mZiwgVnVWX29mZiwgVnZWX29mZiwg
XAorICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVf
QllURSk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjX3hvcihNT182NCwgVmRWX29mZiwgVnVWX29m
ZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUs
IFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgICAgIFNISUZUX0ZOKFZFQ0UsIFZkVl9vZmYsIFZk
Vl9vZmYsIDEsIFwKKyAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJ
WkVfQllURSk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjX3N1YihWRUNFLCBWZFZfb2ZmLCB0bXBv
ZmYsIFZkVl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRF
LCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgIH0gd2hpbGUgKDApCisKKyNkZWZpbmUgZkdFTl9U
Q0dfVjZfdmF2Z3Vicm5kKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9f
OCwgdGNnX2dlbl9ndmVjX3NocmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3Vocm5kKFNI
T1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9fMTYsIHRjZ19nZW5fZ3ZlY19z
aHJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmd1d3JuZChTSE9SVENPREUpIFwKKyAgICBm
R0VOX1RDR19WRUNfQVZHUk5EKE1PXzMyLCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKworI2RlZmluZSBm
R0VOX1RDR19WNl92YXZnYnJuZChTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19WRUNfQVZHUk5E
KE1PXzgsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmdocm5k
KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9fMTYsIHRjZ19nZW5fZ3Zl
Y19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmd3cm5kKFNIT1JUQ09ERSkgXAorICAg
IGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCiAvKiBWZWN0
b3Igc2hpZnQgcmlnaHQgLSB2YXJpb3VzIGZvcm1zICovCiAjZGVmaW5lIGZHRU5fVENHX1Y2X3Zh
c3JoKFNIT1JUQ09ERSkgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

