Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B9C5DF8F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxAfb-0003Gs-Td; Thu, 20 Aug 2026 17:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfa-0003GY-PK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfZ-0004P4-4k
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7Zuk4012740
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tsSYe+63k6J5OlhEmdCWlt5jcQA5iUqgvN/87sBseE8=; b=Yn3hQXhWq0tHVEEe
 qqYaTfT5G/ngHQgVpNL7zyjSD31hIlGAc/1hn4gn1sBUjs/GPDNZGiS/QFcoOx/T
 L36JdPkR8fZj9CC4IQzAraCGRa7CyNNLJoMYffg421Apfu4m3zBuqv969XC41zt2
 T4XdXIatlswwSCJiClVmIDdjN9IyB3pqwdiFAk4Ms+BHjc4CpcfEFQusRZw5ISqk
 pIQGMpo9DZWppNk4/OWxvhLf/9Y1iq8rREEzIVi//ID3x1lyI4LCFak0NPv868n8
 kDR8auNn06j4xDDJSaStYDtzUVkIaOCYFhJ14hUt6TCl5KRexgGNAgCSlhfBRiP/
 c2AZwQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29kfbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so5239535ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787262687; x=1787867487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tsSYe+63k6J5OlhEmdCWlt5jcQA5iUqgvN/87sBseE8=;
 b=Eab1r9X1fNunYW4EEjyUsqD/D6Nr3QMxGopNSawpp0yqGdC+9Ca2LVdIQSnVukofXZ
 6AqCETsQsTnkkQTcdUSw5ticwT5YrK+bLabGBCqPnUc359pWehDgmGHgNF4QV/rLUBsf
 DMt2lNU2VGWmAA9gMoPzY2cVRsRIIXNJYwFi/Jap8byQpJVUda8ozeBul8boE3Zxndyc
 Pi/vqdtQLcjE+5g5ndSEjn2E1vYxaNSR1SUT7Wi+CgAC8s8iN8Zo5MuLjxX4+/O9cFyX
 BmsOdSGCs8OzK2BUB4AnYuqKzMZlOqwH4b60sTTbB4cXtG9Up71reE81W+5DA/VtYubI
 YEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787262687; x=1787867487;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tsSYe+63k6J5OlhEmdCWlt5jcQA5iUqgvN/87sBseE8=;
 b=b7AMIWIKppnfb0oF+xRTZxqJS9eBvCFDAnjenDLNDgnXyPHMLe2ZvC8WTRJM9Np7ks
 c5Xgyi6+QnEEeCwYKpIW/MgSwVU4fHa/PNHbPu5QEXSDCdxhnXWochAkbAMttiVKV5qr
 TVolbN61P8GKqxhdeKJjwS/GIQh3CL7+d9XNpsbwaurLxHpU83/KVUGrnvM5OgLiTgaO
 ixaXguhxnqjYJ6e4ePZF3Li6hFs/6KckHhueiCwNIq+EA3xZAUCQDCcu/MDj9uhmea8y
 2036pr4wswUh3HImdakuBSqJlF/yW/Fe698QRGaAXWiTFzWhWyZiOeOhKqNGC2GQvVQ0
 V/fw==
X-Gm-Message-State: AFuF++mgkqAsab24zYXvfwHS4ojx1MtsHUY/t7lRpILYP4ynSsZMA4Ci
 kZB5s9arwZLmCr1Pz74PxzqKGEOQjSTCnNHS5yLaP1EweCD0SKNq01ODFik59rsfISbl6E5MmJO
 3T3yAvi0mOH5A8eSuMpkeBB1uPj/O0piXyFGEWU4jbqajqRnbeZUR9WzhglrerEb83Q==
X-Gm-Gg: AR+sD12/QY4+ZVxbtrJtJuCFDFWIYlEuOi2RWaSvCQfo8ul3Iez7vpRhl3SNpoMuOPx
 OZxyq/XJuMaF87KWq9gxmnOKZpgwt611Pn7zGJHleprU+d7xL3LzibCd4Dr5LpAVCoPIx/AaUkN
 snHFPkQDLXcjmcouuX2cfkGp8JSl/tNazkiYk5cfUXF1GqEZ4nXUHQBJHfiFJSXtNSbuWDt5nkQ
 wUojnDj4UHPvEMV5ou/VvEwhe038hS/XDosWwGXOlwTnGKerYH/bQUNWZftlHDyibsF8Ko1PHiV
 1dB3bDYgn7+B84a4dozoP/HVSE3KtpY6BBvpl/LNBNgN8hMHl4pH4MuhujeYu7/Br5MscAlvlES
 zTCcTBF8H0r14+CtxlvthNCSsM+sKtI3Q6oJiQPM+EyGFR+8L
X-Received: by 2002:a17:903:1206:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2d64ada70b5mr28324845ad.2.1787262687034; 
 Thu, 20 Aug 2026 14:51:27 -0700 (PDT)
X-Received: by 2002:a17:903:1206:b0:2c8:f34c:82c0 with SMTP id
 d9443c01a7336-2d64ada70b5mr28324305ad.2.1787262686566; 
 Thu, 20 Aug 2026 14:51:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d6168e5bsm9226899eec.1.2026.08.20.14.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 14:51:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 4/5] target/hexagon: fix HVX predicate save size for
 histogram ops
Date: Thu, 20 Aug 2026 14:51:16 -0700
Message-Id: <20260820215117.1788954-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: mhbBpmjGmGtWWp2wTdYd2ZC-8e0bFbly
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a8776df cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Zn1cBpzFra9RJKnzaXUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX29s39R3stAJI
 2vugFP0I0wM+K9oMRCxEMjnMwAfL3bfae2vhAVy9CrzTkp37kppb/muu+y9dUBQHrW8aaZY0ROf
 qYB9H2VNQk1iWZu+mCWusqrIPriitW6xy5+97xRpoAjeZIO/Knpeyz62pNbV29TaeIM8GPhkt4q
 X1TBfAraTmbv3x1UtrLHT9+B1DfltP+bf7xbj5ni0acYySz8fLbUqxQ32y8aQcx1tvS2CzsBhRd
 JHbCu9PqKId1T/ibmg0LsCxaVsnoP9DEfsP0erIv8Oe2d/ytji0E9wwx8fRr8U+Erhy3Ku9iZXf
 lOM4ATuSbn0VMVLWxRsOGh0lAdgAPPfwtk9LMbY/vvVg6jKZxj19G+UN+zqt+esQYdZQT+FetCn
 U5JkmWJy6fQGX1xbXIR7h4vvUfnhVXeFNNjnJIjvLZuoQ5EdRTr+gHcLbnrPWYe4cLG/rqbWXuQ
 y5nHUAli/OmD5IJjoPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX9i+Q6igtmc9d
 j9ztsbRnKlSphZRIWANSc3Mom2ENxS4JotaQpeRndDfU1iI8bgGpnXwshZ0ay/xGB2iVnJhS4A+
 +Cseif61PXTKC6DHG1Cot48TXovtr3U=
X-Proofpoint-GUID: mhbBpmjGmGtWWp2wTdYd2ZC-8e0bFbly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200163
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

VGhlIG1hc2tlZCBoaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zIHNhdmUgdGhlIHByZWRpY2F0ZSBvcGVy
YW5kIHRvIHRoZSBxdG1wCnRlbXBvcmFyeSB3aXRoIGEgZ3ZlYyBtb3ZlIHNpemVkIHNpemVvZihN
TVZlY3RvcikuIEJvdGggc291cmNlIGFuZApkZXN0aW5hdGlvbiBhcmUgTU1RUmVnLCB3aGljaCBp
cyBlaWdodCB0aW1lcyBzbWFsbGVyLCBzbyB0aGUgbW92ZSByZWFkCjExMiBieXRlcyBwYXN0IHRo
ZSBwcmVkaWNhdGUgcmVnaXN0ZXIgYW5kIHdyb3RlIHRoZW0gb3ZlciB0aGUgZmllbGRzCmZvbGxv
d2luZyBxdG1wIGluIENQVUhleGFnb25TdGF0ZSwgdGhhdCBpcyB2c3RvcmVbMF0uIFVzZSB0aGUg
c2l6ZSBvZgp0aGUgcmVnaXN0ZXJzIGFjdHVhbGx5IGJlaW5nIGNvcGllZC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAppbmRleCAyYTM0
MmNkZWU2OS4uZDNmMmNjN2JjNjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
aHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaApAQCAtNTAsNyArNTAsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQgKmN0eCkK
ICAgICAgICAgaWYgKGN0eC0+cHJlX2NvbW1pdCkgeyBcCiAgICAgICAgICAgICBpbnRwdHJfdCBk
c3RvZmYgPSBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHF0bXApOyBcCiAgICAgICAgICAgICB0
Y2dfZ2VuX2d2ZWNfbW92KE1PXzY0LCBkc3RvZmYsIFF2Vl9vZmYsIFwKLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2l6ZW9mKE1NVmVjdG9yKSwgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKE1NUVJlZyksIHNpemVvZihNTVFSZWcp
KTsgXAogICAgICAgICB9IGVsc2UgeyBcCiAgICAgICAgICAgICBhc3NlcnRfdmhpc3RfdG1wKGN0
eCk7IFwKICAgICAgICAgICAgIGdlbl9oZWxwZXJfdmhpc3RxKHRjZ19lbnYpOyBcCkBAIC02Niw3
ICs2Niw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4
dCAqY3R4KQogICAgICAgICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGlu
dHB0cl90IGRzdG9mZiA9IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAg
ICAgICAgIHRjZ19nZW5fZ3ZlY19tb3YoTU9fNjQsIGRzdG9mZiwgUXZWX29mZiwgXAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3Ip
KTsgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1RUmVnKSwgc2l6ZW9m
KE1NUVJlZykpOyBcCiAgICAgICAgIH0gZWxzZSB7IFwKICAgICAgICAgICAgIGFzc2VydF92aGlz
dF90bXAoY3R4KTsgXAogICAgICAgICAgICAgZ2VuX2hlbHBlcl92d2hpc3QyNTZxKHRjZ19lbnYp
OyBcCkBAIC04Miw3ICs4Miw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1w
KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAg
ICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRt
cCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5fZ3ZlY19tb3YoTU9fNjQsIGRzdG9mZiwgUXZWX29m
ZiwgXAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXpl
b2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1R
UmVnKSwgc2l6ZW9mKE1NUVJlZykpOyBcCiAgICAgICAgIH0gZWxzZSB7IFwKICAgICAgICAgICAg
IGFzc2VydF92aGlzdF90bXAoY3R4KTsgXAogICAgICAgICAgICAgZ2VuX2hlbHBlcl92d2hpc3Qy
NTZxX3NhdCh0Y2dfZW52KTsgXApAQCAtOTgsNyArOTgsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
YXNzZXJ0X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgaWYgKGN0eC0+cHJl
X2NvbW1pdCkgeyBcCiAgICAgICAgICAgICBpbnRwdHJfdCBkc3RvZmYgPSBvZmZzZXRvZihDUFVI
ZXhhZ29uU3RhdGUsIHF0bXApOyBcCiAgICAgICAgICAgICB0Y2dfZ2VuX2d2ZWNfbW92KE1PXzY0
LCBkc3RvZmYsIFF2Vl9vZmYsIFwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KE1NVmVjdG9yKSwgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2l6ZW9mKE1NUVJlZyksIHNpemVvZihNTVFSZWcpKTsgXAogICAgICAgICB9IGVsc2Ug
eyBcCiAgICAgICAgICAgICBhc3NlcnRfdmhpc3RfdG1wKGN0eCk7IFwKICAgICAgICAgICAgIGdl
bl9oZWxwZXJfdndoaXN0MTI4cSh0Y2dfZW52KTsgXApAQCAtMTE1LDcgKzExNSw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAg
ICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9
IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5f
Z3ZlY19tb3YoTU9fNjQsIGRzdG9mZiwgUXZWX29mZiwgXAotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1RUmVnKSwgc2l6ZW9mKE1NUVJlZykpOyBcCiAg
ICAgICAgIH0gZWxzZSB7IFwKICAgICAgICAgICAgIFRDR3YgdGNndl91aVYgPSB0Y2dfY29uc3Rh
bnRfdGwodWlWKTsgXAogICAgICAgICAgICAgYXNzZXJ0X3ZoaXN0X3RtcChjdHgpOyBcCi0tIAoy
LjM0LjEKCg==

