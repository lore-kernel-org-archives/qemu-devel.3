Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F22C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7J-00058l-9J; Wed, 12 Aug 2026 11:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB71-0004mS-GL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6y-0000M6-Ki
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbqug3949947
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LePt616kEWNKtDfBxI/yurrB9YOmVQ6VIqf+OGtl3Ng=; b=SHAlSiNALGwD0AjN
 lOF8aRwDpYaWiEI4d0wEhY+XmTakV6pliENKE8IM5+Czw6aeJdxUPzZVxZnS/2z0
 2yaF+/BIOm2pAefQawmNWLuDqSRRpAEkIOVk3LbbbHVWZrfYqnIyYwPDxtXd5aNf
 safO9xclLErkqT27leFOJde6TnjQr8t9oatjfe/9XcytsvG8pTKGA7B1YnbAodNl
 Zy2rpffFT8PX8VEEx3/qGhpnZHvt7q6ak5XeZh0UICDhRPfkLhrvGi47vuTl7bJU
 0IeMFEA2ebWwzCABIaLK32WGu+MQqybamv/uqzksqGtIKgh94Khh+9jkZeiewysz
 S3Adwg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2tsp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1934660a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549392; x=1787154192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LePt616kEWNKtDfBxI/yurrB9YOmVQ6VIqf+OGtl3Ng=;
 b=jEhAclGVZDKG1wCHjf/nSkWLhfV4bnHghpMdvpcx7N6eDVsfDrlTPhrbQ0jwwemcDU
 1WSvspWpoXp5sWwVDgKSp3Jn58jEpTfjXsaL+u2U0OOvSk20AvmlZNIAYpB0wFsbr4mQ
 NmR1EOT/E+4xFVdd0ASWQ/eIkEIz0q72ZEhyiBqXQTXBuNSUP64lGDJfNfqk/HAQ7XkW
 CaupLALSS2sf0wH3CFAXhdgug3pmI9zLSvedqYpkVcHdXdxLXcN/uW2d6I9ZznJM5/5P
 LyBrnyKt+6vS5IgSd3uFCKOOK9YozAR7kRjVzVn8Igc+uw+bBc/OANrdlHfzVWl1ipew
 0GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549392; x=1787154192;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LePt616kEWNKtDfBxI/yurrB9YOmVQ6VIqf+OGtl3Ng=;
 b=NyR2iU+7X0ZnUERqQoOY4v+9d0cI7X2Qcp/5iy7laMbCzJhMn5ce8PboVn4zwXgYXG
 fuw9v7np++SSt/0AqND8edVadU97j9wpLnzuJg6hK0ARmBdYO35TekApSDOX7ERZaKTR
 b4m0z2ZX3pqAoU1dIggXwXgSiNOEO5UtOhRP/6b5ztKfsGBh73NUkUneWMF6D722upDZ
 c+tR4BevHlcWrf0pQ4noN5yIYdrEezURlKI8cmvissjNqIOkWdL+0k4zAllEX7GOoOwS
 +TNzlmOzT/eoi5i+WcoaIRfN02cQyBoRgpzEtyp8n0arKxMGBu26hQZTmpW86a52f+2q
 IQSQ==
X-Gm-Message-State: AOJu0YzdlL+YAo7x8eI2jtmfj8o4vwOeejUuX0KT1aBKxVYEonuR8MpX
 4x4egd5d0Yl7MmnKILyfGnToMBsDIpWnkb9UvwVZ22BF9sCNVdz5PgTB6azpehKeEfLFJMRLQsl
 V8L5h3pOfLubsUdXyI6681awylz6kf755OVLb17AMqgknQSx6wEDfNkiy3fvDC1SPDA==
X-Gm-Gg: AR+sD13EZhEO4L4dak43jyhue6BAJ5X/op74rkBIDWcWmio4yzeLptTZ0UN1pOdcc1D
 5VD680rpjEkT4W4je8MZ+t0n4XbJaNUTGzDy1/6h/wosFhMxhJeQmaCJ9z86/LpiDzxopFn8Mym
 DAeZTavndhGQIIJyHVB6iTL+Ddt+4phOIT+pjAOkLI1YZBySiomB7CXpjI6oAyp6WjReex4zCcE
 gLHydk2j3IZfBDFUuK5vik3SWtlnCPXQrYF1qGsr5y0Zqc/jFWRXeh9cQFzI+OuRqAvYaFsn0Eu
 GCo/W4wWors4JKkof54iP6JJ0JVMRADZKc/dis6c71KcA5eM8SgIc4d/HB/frtTwhk7mSAphXDB
 rXfvs7CGuSnG8Z01f4wd5vNSgBF/c4p+pkuDURVtt7Mccibg9
X-Received: by 2002:a17:90b:3f85:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-393012c974amr7486185a91.10.1786549392469; 
 Wed, 12 Aug 2026 08:43:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3f85:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-393012c974amr7486105a91.10.1786549391960; 
 Wed, 12 Aug 2026 08:43:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 23/41] target/hexagon: add GVec overrides for HVX vector
 average
Date: Wed, 12 Aug 2026 08:42:02 -0700
Message-Id: <20260812154220.1029828-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c9491 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4RYLHjVto7nR_YSnh5AA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: nisnE0e1JLNdMPSaJI1uW8soYiPWs_tY
X-Proofpoint-GUID: nisnE0e1JLNdMPSaJI1uW8soYiPWs_tY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX2jonTGpA1PJj
 +OmXnhPLah9+I8v9D3MmNBBSQFYTKgNrEVsAf0E+SDRsUTAwYpbQ5fWSGf3l4aCXzScenB3bgvu
 DJliw+1oEXNFJwLs4EuYB2GeH3XVGfg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX+7hleRjFiLiQ
 AgjQ7jG11zIdfl56V5Cg9LCuy2VnDU1ERul4y953Lt/1Sw+mQ+sua357L7HaAvHcK3RlKConlcM
 l7tUZA2jMgt522CuwdpoQV5DdPpLv5o3q3gf1MwIyOyTEsB92fiomTtX/goSckC583UUFLEC+kI
 0tKvKElw/OCSfgTn67IVJUxdiyffF7dO0s1n/b3g6MweF/URL+0WYHUWrZqnCoI3JV11mihgSJP
 99K5dgDvkyakedBfRuogk7ZfFa7lIo9bIlC+OpM0wGv+71AD+O1tlp93c9fG8IIpCtgOAtgbhT+
 LA6T6pERNslUg3bXg1LyxnT+R94yLoGrHBPtxHYqw7TArfAXuiNhGOakdXA29SzsNo9HKEsH2+u
 sNgdpeIEC4FOeaYJIVe8Fvb/60421NfP5jfQC5S/w5/C0ihq/ZJ/uZq1hxrkeCpjvgfG0OD9YdO
 Nebi05ELDnq7rBb2rWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MDcxNTIyNDEu
MTU3NjMzNC02LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19odnguaCB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAppbmRleCBj
YmY4NGE4Y2FlZS4uMmEzNDJjZGVlNjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaApAQCAtMzQyLDYgKzM0
Miw2OCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQg
KmN0eCkKICAgICBnZW5fZ3ZlY19zYWJzZGlmZihNT18zMiwgVmRWX29mZiwgVnVWX29mZiwgVnZW
X29mZiwgXAogICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJ
WkVfQllURSkKIAorI2RlZmluZSBmR0VOX1RDR19WRUNfQVZHKFZFQ0UsIFNISUZUX0ZOKSBcCisg
ICAgZG8geyBcCisgICAgICAgIGludHB0cl90IHRtcG9mZiA9IG9mZnNldG9mKENQVUhleGFnb25T
dGF0ZSwgdnRtcCk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjX2FuZChNT182NCwgdG1wb2ZmLCBW
dVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVf
QllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjX3hvcihNT182
NCwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICAg
IFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgICAgIFNISUZUX0ZO
KFZFQ0UsIFZkVl9vZmYsIFZkVl9vZmYsIDEsIFwKKyAgICAgICAgICAgICAgICAgVkVDVE9SX1NJ
WkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjX2FkZChW
RUNFLCBWZFZfb2ZmLCB0bXBvZmYsIFZkVl9vZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgIH0gd2hpbGUgKDAp
CisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3ViKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENH
X1ZFQ19BVkcoTU9fOCwgdGNnX2dlbl9ndmVjX3NocmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZf
dmF2Z3VoKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fMTYsIHRjZ19nZW5f
Z3ZlY19zaHJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmd1dyhTSE9SVENPREUpIFwKKyAg
ICBmR0VOX1RDR19WRUNfQVZHKE1PXzMyLCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKworI2RlZmluZSBm
R0VOX1RDR19WNl92YXZnYihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19WRUNfQVZHKE1PXzgs
IHRjZ19nZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhdmdoKFNIT1JUQ09E
RSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkcoTU9fMTYsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCisj
ZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmd3KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19B
VkcoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENHX1ZFQ19BVkdS
TkQoVkVDRSwgU0hJRlRfRk4pIFwKKyAgICBkbyB7IFwKKyAgICAgICAgaW50cHRyX3QgdG1wb2Zm
ID0gb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB2dG1wKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2
ZWNfb3IoTU9fNjQsIHRtcG9mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAg
ICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAg
dGNnX2dlbl9ndmVjX3hvcihNT182NCwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAg
ICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUp
OyBcCisgICAgICAgIFNISUZUX0ZOKFZFQ0UsIFZkVl9vZmYsIFZkVl9vZmYsIDEsIFwKKyAgICAg
ICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAg
ICAgdGNnX2dlbl9ndmVjX3N1YihWRUNFLCBWZFZfb2ZmLCB0bXBvZmYsIFZkVl9vZmYsIFwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRF
KTsgXAorICAgIH0gd2hpbGUgKDApCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3Vicm5kKFNI
T1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9fOCwgdGNnX2dlbl9ndmVjX3No
cmkpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmF2Z3Vocm5kKFNIT1JUQ09ERSkgXAorICAgIGZH
RU5fVENHX1ZFQ19BVkdSTkQoTU9fMTYsIHRjZ19nZW5fZ3ZlY19zaHJpKQorCisjZGVmaW5lIGZH
RU5fVENHX1Y2X3Zhdmd1d3JuZChTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19WRUNfQVZHUk5E
KE1PXzMyLCB0Y2dfZ2VuX2d2ZWNfc2hyaSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YXZnYnJu
ZChTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19WRUNfQVZHUk5EKE1PXzgsIHRjZ19nZW5fZ3Zl
Y19zYXJpKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhdmdocm5kKFNIT1JUQ09ERSkgXAorICAg
IGZHRU5fVENHX1ZFQ19BVkdSTkQoTU9fMTYsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCisjZGVmaW5l
IGZHRU5fVENHX1Y2X3Zhdmd3cm5kKFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1ZFQ19BVkdS
TkQoTU9fMzIsIHRjZ19nZW5fZ3ZlY19zYXJpKQorCiAvKiBWZWN0b3Igc2hpZnQgcmlnaHQgLSB2
YXJpb3VzIGZvcm1zICovCiAjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhc3JoKFNIT1JUQ09ERSkgXAog
ICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

