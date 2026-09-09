Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6CDC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49VY-000717-FS; Wed, 09 Sep 2026 00:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VX-00070o-52
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x49VV-0003uW-LI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:01:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688MgHqi3655018
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 04:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XeMrqFjhZ8tSL16ElvJ4yVeUyVqjIuJmhTWqYfJ433k=; b=kXqJ+MiTWNLu8y7t
 OSDlsZTosUlRBv1YgdSP3zBpmy///7hX1xrVH3y04D6CtL8wvY8nUAnHzuY3X0Y0
 RkB00h1njilrxuB1LO+ufpPyIQpuN+5wzIvBOYVL0ODZ5QqagC6hs4TR8tTOeGJm
 wFdjG7LewrDKvVkvx/7c1E4V8fwG+G6pvRnb2Tbn+T+dGMFmeDogXPHj8a7qapXv
 YMe1FF5vV0f1J6ITRax2pcupOmnMqUYlOrZqNYaekFkN42gvaLU2iurs1uAcu5hc
 BmR6xui10QsxJZPkSefV9iD0uFPuLca0LmaqLbX+aRU1dfyXaT7pWlHwx4Cqx+TN
 BzOMkA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp292m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:01:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-868db1b2c64so210302b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788926516; x=1789531316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XeMrqFjhZ8tSL16ElvJ4yVeUyVqjIuJmhTWqYfJ433k=;
 b=UC1vGZiJlgVF99BOzV39QHI85us9HVF5w3s+wj0Plz2ki/+76Ww8NgedranLNOb1dA
 lNZu9zKCFdD6ZEH3GI34B29R5GDSj21rxYLZmh3UhuDxLLMdFqpClPm5FmzYsvi4rr82
 sCf0Q51uPOrOLCy83dEi6s8Ix5VKsNaEg327O+4QqjTSlUmPVu4UCRrK2P35QSAY4Rds
 xo9O7xyKPyXxRHPnIxB1+6KlkeCbFnmmGbfcN6bqQUvWeSsnBupV7YXBg9HuhO59hYWR
 /QKEL1soqXmhxFtuGTM2/NiRpJ1szSVP0FJxVeh5bvD8N8+P/c91wZ0Zeb6YYAFB+UDH
 QrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788926516; x=1789531316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XeMrqFjhZ8tSL16ElvJ4yVeUyVqjIuJmhTWqYfJ433k=;
 b=kD7QyqH0Eyoc5OIjUB5oPs1DcN3kA9KesxaEk1NyczDGE2Pg4uoavbUnlp36X75W1f
 h8SP7PjN4LDAkPsdVCAS+JPEUexe1vnfc5Qxh8+yjtPiXU8uam9vHTVV46jl1aHjUEpO
 oQD68xUSuCvOfzMg7JxTsIXd/I9FXca39XmrFYJGNbpcezDQqmakiIj/rBpQcJslLKHe
 WQBu/hqWf5yXxgIEJlxuangMbX/s8fwDmI2r0CiJkBKQimhD0mAvPxfpdzTcQKcFpL8N
 IAH9ZMfmMpkIPGX+jcDA38AXwgsZf7ZjKea3IkAExIV3HCmF+daCJk1CRPZK1cV64vPS
 T9ow==
X-Gm-Message-State: AFuF++lIoRcqi+swXB/g8ldX0GhDBtJIaF9wOGHGUsxtSR29zTMh6h1n
 c3lKsh6WW5cbV3QpuyMy7LA0bQz1DCDX3KydUYTHrjcTqek3mzLxQ2FxeBl1ave3yrtr/V11prt
 +WSGMNiUCz5OVzuxJ9uWZ2TPZfcD5+GZOuJqA+WK/VGXWKwwr8MkiY4MZO0Co1Lx9Ag==
X-Gm-Gg: AYBFou3sK9YVlmgDTfEDSuNIzXhT0vI05VLH/AAaIg0uVOotjmPMvk1HTxFmEqF+sRK
 KigtwtA4aBRJM3Phov+E5lFKhTI5cUN/nNQqT0KspTz27ImMcCZ+4jvxVJ9/o+Q+KQbLrEzBDzV
 yD5sF5JszJMYM7r9KnxFE5D4LPakAr/H7CvnyfDUp1vYQ8su+aT4KO/JLaNWOj2SouXIdsD/2eQ
 nqEolv5zH9PnXB71J5ydpwUxk5J1Yw1wEcsj9f4r1yetwGp2CX+g+aCYm4BRYLkK2K9ylbjeT/s
 3LGwwR8C9pjwpZ9ksmBYpAN9AG7kU0OJ4x/fomPAjitlLPv5aSIXhzrDUOPRuN3XObHsX45dqks
 L37T+oD/sBBvOUlSJwKf1tHU/j0RkbTxxxfQA3gcjYQKuktfW
X-Received: by 2002:a05:6a21:3b89:b0:3da:421e:40f3 with SMTP id
 adf61e73a8af0-3dabb1d5fcfmr5467042637.17.1788926515519; 
 Tue, 08 Sep 2026 21:01:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:3b89:b0:3da:421e:40f3 with SMTP id
 adf61e73a8af0-3dabb1d5fcfmr5466156637.17.1788926510286; 
 Tue, 08 Sep 2026 21:01:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm20407002eec.25.2026.09.08.21.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 21:01:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 6/9] hw/hexagon: move "sim" alias to "V81QA_1"
Date: Tue,  8 Sep 2026 21:01:34 -0700
Message-Id: <20260909040137.3414132-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: jAn3CJB1a4aqy9nHDkOc7lnpPaICPijX
X-Proofpoint-ORIG-GUID: jAn3CJB1a4aqy9nHDkOc7lnpPaICPijX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfXxbfgc4DPmJGd
 y4Cget5m0YN9VE4Q6NKO8hvEPVgeGGwsextseqGiNCKpHYd/rZ6chpaWt46BbswdUyh4Bt0vhls
 lbtM70Q8LG1kqrft9wbLG0BNcv0f8Qgwcg08f2yT9tbbvyKnZtDgutTJmE/lkKjWU/xA8JjlclC
 Q2IPnOoYMRiopph6qO/cUlu3oGeAATpXDeZDQDrT1wr1G3jSGiPtiFEHKhSmte5qDuzqM515Ljp
 2Mqi6eXy7ckDV/ktb46XbAVV1H962BiQVAkf841bp+W+YhgM7Yf5jLzs00bam+2QhTArqspzDKI
 k99GqIA8+1kTKe8d//kIELB3O3veUTwZ2fKzaCet4zm9nLPge4pA5QgmJSE3tcfL7EoXF4o3rlh
 IvdXcxnGuVXW2dEVaKV5jU0raSUfWv16WC//gwg4aHOh9cyaqnjnXaleh3HrYFV6Rg+lSdjXVuO
 Pg//tfsde2wz/YK5trg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX0RUW5ZX+GSW1
 E9WrF8Bfr1scCvCRF9h7KscOcRwdq8RYYddSPbOSwWj0PjFLRfMe4j8hhyVzC+t3hF1xEwXkZjd
 8G1KOi/NR2rhmBzj5tRFlbCoTMw1tPY=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa0da34 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kk5yy-eOBfP67cS8hnMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043
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

VGhlICdzaW0nIG1hY2hpbmUgbmFtZSBpcyBhbiBhbGlhcyBmb3IgJ21vc3QgdXAtdG8tZGF0ZS9j
YXBhYmxlCmhleGFnb24tc2ltLXN0eWxlLW1lbW9yeS1tYXAgbWFjaGluZScsIHNvIHdpdGggbmV3
IHY4MSBtYWNoaW5lcwphdmFpbGFibGUsIHdlJ2xsIHVwZGF0ZSB0aGUgYWxpYXMuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaHcv
aGV4YWdvbi9oZXhhZ29uX2RzcC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5j
IGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCmluZGV4IGJlMTdhMzJlZTEyLi44ODI0ZmUxMGE1
OSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24v
aGV4YWdvbl9kc3AuYwpAQCAtMTk0LDcgKzE5NCw2IEBAIHN0YXRpYyB2b2lkIHY2OG5fMTAyNF9p
bml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBNYWNoaW5lQ2xhc3Mg
Km1jID0gTUFDSElORV9DTEFTUyhvYyk7CiAKICAgICBtYy0+ZGVzYyA9ICJIZXhhZ29uIFY2OE5f
MTAyNCI7Ci0gICAgbWMtPmFsaWFzID0gInNpbSI7CiAgICAgbWMtPmluaXQgPSB2NjhuXzEwMjRf
Y29uZmlnX2luaXQ7CiAgICAgaW5pdF9tYyhtYyk7CiAgICAgbWMtPmRlZmF1bHRfY3B1X3R5cGUg
PSBUWVBFX0hFWEFHT05fQ1BVX1Y2ODsKQEAgLTIyOCw2ICsyMjcsNyBAQCBzdGF0aWMgdm9pZCB2
ODFxYV8xX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkICpkYXRhKQogICAgIE1hY2hp
bmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsKIAogICAgIG1jLT5kZXNjID0gIkhleGFn
b24gVjgxUUFfMSI7CisgICAgbWMtPmFsaWFzID0gInNpbSI7CiAgICAgbWMtPmluaXQgPSB2ODFx
YV8xX2NvbmZpZ19pbml0OwogICAgIGluaXRfbWMobWMpOwogICAgIG1jLT5kZWZhdWx0X2NwdV90
eXBlID0gVFlQRV9IRVhBR09OX0NQVV9WODE7Ci0tIAoyLjM0LjEKCg==

