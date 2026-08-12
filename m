Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39366C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2UM-0007LR-FA; Wed, 12 Aug 2026 02:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UC-0007Ij-9w
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U5-0003ru-Pz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C627Tg3506015
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LePt616kEWNKtDfBxI/yurrB9YOmVQ6VIqf+OGtl3Ng=; b=oWIaNlaVFCumFLux
 nmLtpIzHXsHSzhEB2HIJOxIr9Kdt6tOapgqAQmW4Wn2U+WssTKK17v0oLOAyho4z
 NvQPsoMzG9K65r75PCEE8ipKnZH9GffzxmSukXqefZQt4EFiZklIXiwRrWJ9kxq7
 CIEm9w0uPUwctDGFY4KE2E0J0MTSY5HwFOW9yTNcIrLHvHhYE/ZmArzu23ESVOnc
 KFp0d9sbbDeaTuymHssDAPY9yF4Xwruog8vS2ZdJRdtE86vYohVtvoUa1pRex9Wb
 3/JVGIZ+XGxz14pub0KNUeqWkb2Q0Lw/CwLU8TiL9kOTy8KcFh6IiQ5/FRiCV3rc
 g7pmPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5jekf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-392cf18db8eso921784a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516240; x=1787121040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LePt616kEWNKtDfBxI/yurrB9YOmVQ6VIqf+OGtl3Ng=;
 b=esC4tRm0Uy99dwPoHgB4+t6XrGqKrHOlBHHJtxqVXJ5FYQ4k//8Tku05FhV3kB43JU
 P+FWgsWne2sbSc8TBncECwlS//eJrMLlTCfVEU+RQD/imXauGZCNDw6m6n3okU1vwige
 cjN7O5Sx3C2IbnzbEpoB29KrnMbxRS4RmdgpWzEltXXg44jRSqPSJJamwLXUvgCnawy5
 YS/uDGV3FnfPmeQi5ZdwJJ8GfwtRnaEi8qGEp9z3HLNS0jI665yPtxeH7v9JGIi3QFKV
 oJqtB+l4S/l+7Ipi1pDK5+M+USquSptDHq/EqGZxYBrpP+y7ap80HvLpxfkF9BYrVJhL
 LsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516240; x=1787121040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LePt616kEWNKtDfBxI/yurrB9YOmVQ6VIqf+OGtl3Ng=;
 b=GyEYZBQC3GuyrWQrEbUCFggnk+xJ26Ub17HbPwnIBu0PtEU8uBIWQ/cOupWJ1ro2mg
 hny2A5xF5SMNuhEFARdRPRS2b+Hxf7aVMWWCvnXXHaAOYAzW5qnUfHBzYlyEGGn1xFiz
 jgSWxhsyKD+BaR/4va5M1mt4K5rX2ahn3uhoGtlFetRs+xHZ/6/ON0vUn41iKBpOBEon
 4MftyOxq4x7ZzF81EC/RciV1yYPnbJDgZ1K0tmnhFme+4jnHdPQccCqUxX8wrn5jLWS4
 eJ4niDEhrcMYwWARkq2Z6DOPOyLxAX5ElNFtUbU8dx4mM//Cw0Id2uiA1MW3Ez6qg+/j
 XAWQ==
X-Gm-Message-State: AOJu0YyAi8C/T1ulnCn+5MNS+xwYCq1QL3CNCTWmKNVllgNGuUrRMx2L
 8n05Rpsz6ZpvCPyaKAHZcVrlxeXhLv3SFZvGlmOQkjlrOOSWIWlqpL+k4ecbVNDbqSMIJlp2uTW
 pNxxQHQp+jHmi6frQcJSOYAMh7T+qmisBttUg+Ge2qJC8VYB3AuFNPlti82aprEPyBQ==
X-Gm-Gg: AR+sD1092fWVo7lHS6sxTG0rPdpuul/90WgcjfP8L2Aed3wikOVSgxQ2HNEIGVmnuf+
 9RbFchwylOnVY2Xx+XR4SrJycCOsE/LSoxWozdSHQY6iChjPJOIWdMTWmZM/8/Jh+3oCkoAiVAc
 FKHlg1gGbBk1VuX2YVp9PmJQy8796uT0i86DACwuuCUcSFJvCeNjOkWNKi0h6XbChAvV6xxMvqY
 Nb63uvBDgw/zwXLXYOHQvVWlOw3AeY7d/iES1FsB/KM40pLzbpIa3WznF31RKnCliIEsS/JxAaw
 bII8C/sD3+MZ3b+EyrNJnAo7l7eBFDFjOZGUc0RjzBeQb6XUlzrcmQ2Fw6JvYT+dGDjzehSfdzK
 5hd2aibDttgGMm2QPNWt1eTUaGzcHRTLk0sDWvZHgq2vStLyk
X-Received: by 2002:a17:90a:e7c6:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-3930164ea38mr2710805a91.15.1786516239788; 
 Tue, 11 Aug 2026 23:30:39 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c6:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-3930164ea38mr2710752a91.15.1786516239288; 
 Tue, 11 Aug 2026 23:30:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 23/41] target/hexagon: add GVec overrides for HVX vector average
Date: Tue, 11 Aug 2026 23:29:14 -0700
Message-Id: <20260812062932.543840-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfXxmTSbulG6gJJ
 UMTY0nJ1c1mitTZr9RGWIhXi8+TIkeYVg/Lm8nBIT08o29Ewwe5UDaycEVEMbdJug0k6A1lJa9A
 ZDuIbwPl654mrLgpOn1gp8YFUA4qCEE=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c1310 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4RYLHjVto7nR_YSnh5AA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: h_yezWfKqdw3H39jOJ7OX2NOTVUpqWHM
X-Proofpoint-ORIG-GUID: h_yezWfKqdw3H39jOJ7OX2NOTVUpqWHM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX3U927G0SBZx+
 ZJkvZyhoW8UGkZBvkd8JKwGVWmhFoOwR2haC3RPqRXbKro5HgbxKMZXAqbWVz5Y/DHxRAx62ILG
 2+3bTXIMHgZqG13uLQPMJURQJ+m9+agABTf7EaCeZCItTyDXtTZGv5SHIdzEnzYfwifDCP7bsuI
 6Sr3Ja7LbG0YBnejfogGq9Y0Yo6+cP5RuiYAMT7Ub0KzpHPZb6DWLDvIEIyQLiBHbvaQDU0ngsP
 seD6KDJuyqHi35Xyeb3/6i75+cqdX6cmu7G1PmXgY9hPV4023T7ww09fJECoSMHAffGtrp5hwZc
 n8AgVVDJZBoCQdgJnRbXGMPxlU8tZMhsB3uyAXv7RcXB/ZdbURfHNfdOQDBZBEe1OrDo9S5arwa
 qTDTvDDp7gNIMLtsbSibLpnioY6uFni6RpdiYDlZCvljiBZQ5SyTXIXhWNobtJJy7DfyMA3Anz0
 KT7PyftR0QMEAAl4Gig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120049
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

