Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECA606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lHcn+7WZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V2TgFplX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvue-0000Oi-VB; Mon, 19 Oct 2026 18:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvud-0000OQ-S5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:33:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvuc-0003OR-7A
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:32:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZNCj3070785
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EnjT1Rrl4cHcKBqvVkPWXf
 LwGJYZ9W6RQoIFlcJKcmY=; b=lHcn+7WZWeYFmpugu4F2FL/YPmgPPteWuNiD9F
 UN5bQgpk4hNxZwsHdsuKBvNNglMVSzRWWB1WjtjHYpGYxEgsJUALsdtQRqJdgfts
 C6gOi+h78dDyaMCP4mcP/BS2K+QJO8GDDsme9zLUUgN4g5L/xE5wOgJ90z6OhGuS
 jQaZ46F84TQLPRMNJZcMcsObj6XnAB03xOI3k5/PhMmR4ya7bsrn716ambuy4y9t
 cagS//J6neS8w/71sg1yRwgO1j+67gds2VtygeYUZIeNFEhUbRIz7OwWFxGzeJkf
 Mly/6dvKIvJg014UDbHwEpPqLg/HrhepfB+2/15Nf6cThs9g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0xh0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:32:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3662e7a9299so34853eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449176; x=1793053976; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EnjT1Rrl4cHcKBqvVkPWXfLwGJYZ9W6RQoIFlcJKcmY=;
 b=V2TgFplXlXU4BJZuy2GjjpIACqr0FLrdDuhVnjO6geDo9ocAbpxTc0m3WkFLdIFP38
 XvIsUqFMsoDc/W5u/mA+kVLlAV8Q70bNrgvHb9sOHpY2qnDPggfSqveul30Of6+mZKGW
 st1kWENmqn28AUspS3kArasnj7mUsjvQcAVt/eNE7I8vZKDbs/1sabIfLwY7Omih4UqT
 z3A0o2eOcKSmyBde94WXf8Mbpx9v6kN19egowfIIx5UBrfcAL15ktP97x0kCrn6CCsxY
 P9nWFJEpgduqOscNjRht2yJJn1pfIMmGMmtUqZsA0sSosf+l4glp1eIPkGqRVVPVyeqh
 K5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449176; x=1793053976;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EnjT1Rrl4cHcKBqvVkPWXfLwGJYZ9W6RQoIFlcJKcmY=;
 b=FpvBVPprfMIYzb1j2Sg1LEkRQyvN9x6XIVA4mrMRtwDnBXjM1DNSGoq+Tg41/cZCk1
 T1+pnYG2yyAIzJz7OHA+lxhrswo7urohESi/KVT7WMUiZqov5Vc4YfJw783acQy6kr8G
 pBqugQKVRWWqK1RNw1/KxF7myNq6mJovfAKotp6cfLxY+3DxIwDbigwB9KiOriIzVdg8
 3NbIvWgJeVZ1J4xylhUD9uk0RhL0gahMDwuZzq7H88a53meV9una+I+VIUanIGIY79Tx
 vbaHaczw8FAUMkTvmSnnjd3sDdqf71Xs9GJCKkaOww1IpfZZE1h6kLOhnt2s2VCO30mn
 86gw==
X-Gm-Message-State: AFq9FYJ9U8el0eUlEzKiYagPYInqOI5lKimMN/9N96pyEeaLvv5VA0bs
 gQlY1HHD7nRygXP6ulnuyteS/xN/6zRWoCxqMcpSvVjDV1fnb94xnyzO/MR4Ep5d0fZY3ZKHElX
 0EWNSsxYeVTe3P5o9JoVT4lDEOzAgpGq2BLGKxM9HKW/RkpjXV1FL5MLExjLW078thg==
X-Gm-Gg: AYBFou2g4YSrFhCXwicNNEAIWBfvnDuVLCxEJ3xXfSjQ2Gluf6Zc85ncix+24D4BdPo
 iUe5C7I7akmznaO2iNYGpj7KUgMa5SK2qbi+jshqXhCWuai0gh8nY8hRAvZvoM3nbCaAc4cHr+g
 OUNRm7HO2U6RMtDrtKwRqknvxddyhq7ZSljWExyek4CW64LW3wy2lxpCPxQuziKxzKkkhROS3SR
 CosF+JddiYLrdF88BXzgf4sQ2UtQIZjX6fOXVR18wLpJb8nwxqk5boJX6ARC8ncbvT18kYICwAa
 HjR3MTVLcCk1CRYkzOBdCw5qmfytURmiJyImYsrFRnvH/I3Bv61fy275ch8ZKRLl9NfGERNLUAl
 fQV17hlK9RDWLluh43MdytOPAM0QgJAytgR0skccIGtbQJPw=
X-Received: by 2002:a05:701a:c907:b0:143:2984:6518 with SMTP id
 a92af1059eb24-18514729a00mr13303766c88.39.1792449175766; 
 Mon, 19 Oct 2026 15:32:55 -0700 (PDT)
X-Received: by 2002:a05:701a:c907:b0:143:2984:6518 with SMTP id
 a92af1059eb24-18514729a00mr13303720c88.39.1792449175035; 
 Mon, 19 Oct 2026 15:32:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm48294319c88.11.2026.10.19.15.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:32:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/2] Hexagon: Fix undefined behavior bugs
Date: Mon, 19 Oct 2026 15:32:51 -0700
Message-Id: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 57QR7Xuyb_wsvpZM1-LuPDHcxvERd3x8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX/sLy/5yyc1ij
 56GHuDoKd4/0nqSzAZJVP+NP6WGvxEFjOaz3IMVx6n4gVNn3BUB/Yn04hEODWMdPTesTysMTeL4
 fEk3TrdBPMuzvcbK91NoBJaNT9fqBrljN22l7bMyDHuoUPPbIsnbE5IKmL9k4xCWUjHGsHMHHfy
 sujujV1sla5YI+36UevMb2m+S9wa3ErTK8aryvPYOzuB6dtqv1AwpCzRbbixeNhJQAUEA4T6P5e
 qM11My7EJIENyp7fnFYqdIT9q2CdcjQ1Izo8KP42fDHcSnyg5A+3o4jQm1EDyb5pMUPBTybpM+g
 xvJ9Iiq3ZEStIfmZpA5ih9bckHymLGgo6PvTLJ6Goi5Ng8PXYaZgI36S2b2Q/MifqlTtyfHlyrz
 /cEmFd3yKuYEN9wgGtqUYyC/IcTzAfT4pGhjSBXr6w+bNAQbfPel68CDRXY2tbUPrKcpVljN7J+
 GIHOy5EbKaIBQHuu03w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX7t2uU6mQiIWB
 +Q04MthmJo+UAdBlnPX5P38WmDBvG5heYdX+SgoEhkQf5xawYIEU1bZZkyvl4IlKwJT3YsVYKqh
 vGjBqO6M1ZZ6WfsA34jMYnWc0yv5+3A=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad69a98 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KLkcmpcwI9KSPmiwA6cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 57QR7Xuyb_wsvpZM1-LuPDHcxvERd3x8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190089
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

Q292ZXJpdHkgcmVwb3J0ZWQgYW4gdW5kZWZpbmVkIGJlaGF2aW9yIGlzc3VlIGFuZCBVQlNhbiBz
aG93ZWQgYW5vdGhlcgppc3N1ZSB3aXRoIFVCLgoKSW4gdjI6Ci0gdXBkYXRlZCBzaGlmdCBhc3Nl
cnRpb24gdG8gdXNlIGBzaGlmdCA+PSA0MWAgaW5zdGVhZCBvZiAzLgoKdjE6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjEwMTkxNTM1NTguMjQyMjI3Ny0xLWJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDIpOgogIHRhcmdldC9oZXhhZ29uOiBh
c3NlcnQgcWZsb2F0IHNoaWZ0CiAgdGFyZ2V0L2hleGFnb246IHJlc2V0IGltcGxpY2l0IFVTUiB3
cml0ZSBzdGF0ZQoKIHRhcmdldC9oZXhhZ29uL21tdmVjL2h2eF9xZmxvYXQuYyB8IDUgKysrKysK
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICB8IDEgKwogMiBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykKCi0tIAoyLjM0LjEKCg==

