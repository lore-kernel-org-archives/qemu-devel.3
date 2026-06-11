Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061FCCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2V-0000ua-VE; Thu, 11 Jun 2026 01:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2S-0000ZG-8N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2Q-0002ZS-Dj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GLVD3725008
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=NccfXo09r3VYJmen
 H17mmcS4wIZQsBQ6ZCtSQhCF6ZyNurOXYYiJn7xm8amsrVmymrXkyQo6um00LJaW
 9R0Tc82lJwdPpm/koxTqT8J2Zu+Tfs84Ev/YW2ZTrwUD+nqogMpt3rAt0YF3hsXc
 xGfurrznbiqAOcS1PlsL6W7ckPg4l0hXMzCRRxavVgbkyRSmMrCTG/wHOOOyogou
 uH9QPiHmVpskUJyjKTGLn2LjFMvqaamj6wnxAFDyJiIeibXAz0am0J7zzcBu0O/s
 NN7s/QdZByBrsTAmpkmXtYh/Ar98AFDNbibU9s0cimYPGIQta4HV7eds215YxZQQ
 Muz0pQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307625ee07fso11482402eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155988; x=1781760788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=iHxo8AcJeXmuRVvPPRsc/b3C9Ko+zmH7a/0NuZWozl/Akt8SHPvYt7+2rDIZCv04WO
 tUr7BsD4HujkhG9rwv0nZwddxcNY9JUxuHZwRBAmy4y83hwaL17rUfVYOw3Epf+YSNxJ
 +S7gJY009i4tRes0t3m6JKKkDufj+u47Jcvfsgx/USQ3jmQi5fd8PzrjfQBIe6nDd6vr
 8eZ/0JtKo2+K5jOZ5fGOCU6/1ASwstRj0AyBVDRhqvex1tkO6WGRby4EjtxXQhcSlDNl
 9s2/FnhB7wlYrrxCXzVYTeyxk5DeBKjqZG1x335JgGsBUUU5m0E2jn+NpFs5UBS4tOeT
 VarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155988; x=1781760788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=CEH5WpSvLGLUL5DgMmI9q8B9L9eCYN0Nt00dH0uRtFg2txHona1NDgS2ixKhpwrOTw
 aE1EkA0STQlmNtguO063apkg2SyAlTIApRPXH/NxWVbcs4k7o9yS9Q3DdORSZcdA5If0
 Vg+P8h/jmFP8x4ygG3F20q5bIs58q81+H9FK2+Zs2zhgq8+tmAxh8uuFgOquOglwSJtq
 Ippp2GpPK41gOQ1/nuHSjPCAAa6700Y9j5myof9aHNRlE+bZcSra3DcpSTORhQuho4tv
 XHUxJ/26eIif90N/P91vn1UkXKpUWO1okuVQ8+3zOtjnTnm3Jrm0LY7h8+g9L8g1+HO1
 N7Pg==
X-Gm-Message-State: AOJu0YzsVvqev5Qdv64rpp7cXyeI416rFseGRWZUuR5u0Q3bbpl0hBV9
 YaxSIBkDdO0tLDC+ef5c2C4Yqeh6H5eKdQjhBZETkGN3ikybSNyXFSu7472S7HEx9Ja5LQROOhO
 INZ8cigOpbmwGTSRFeV8UwQt8iOnxeqrgF/sSArEE8ps6cvsLhrNepMOmNxffFL/kNQ==
X-Gm-Gg: Acq92OFKMVf+WrwSDJTxQJ1W9MSZLiT3gsAlIFOG4g5UWQT6XS16lFm2USqgXzJZ6Dy
 74ljVzC4xoDtYju/pcAE+qkBWKapSdv6zsJhbeir7bDBklsZk3uM0iI88Xl76GH8EqGzuMpzSh3
 yK/L9zuIY8B32k/V59yx0poWeUMEvuZXGYErWQcHXVbd51sqV5oGdK30562zNdj3p9YfBk9iJCJ
 2Rfs51l0r8pprogG576ZxKozCto6BddkgblhX88y0F3KFYrCmiPoRlskC1AlZcWFBbKm4Jpt9ao
 9mBx9/AU1Z3wDvMB/BwikPJEkDgog+f2mN/c1/7+B/ChjvNSy7Cq6+5Kh+LMHD0FBKNzMmj1Kho
 SwU1lFWqMPGFFO4ak2YcMc7Y1r4xX3mzvIbtkGN0gI+v2z4ar3Ty50WEL0B3cgvclL7mKwGgnnn
 /X+yZm
X-Received: by 2002:a05:7300:542:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-30804b96826mr1128683eec.30.1781155988207; 
 Wed, 10 Jun 2026 22:33:08 -0700 (PDT)
X-Received: by 2002:a05:7300:542:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-30804b96826mr1128673eec.30.1781155987715; 
 Wed, 10 Jun 2026 22:33:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Wed, 10 Jun 2026 22:32:28 -0700
Message-Id: <20260611053249.3918491-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: Lf2otiJraZ2zFDxlZFtsTKKcM4wfGVqd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX+3EF2gmowlmS
 /7EbXzZ9oneQWf18UaxRJe69QsvmO2Lr1KQtWHngdmdmFuNyEQCgMXr7YLLcK2ZNAdgg45x6nrI
 Fn5PhDX/dISjRftoBoZzTEh0vSbk7v0=
X-Proofpoint-GUID: Lf2otiJraZ2zFDxlZFtsTKKcM4wfGVqd
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a4894 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX8xQ7ATfTvtDu
 HAiD/O/OG5f9YytK93mvwpfiu2Pw3A2/vELb8hb37OCZdwTLJUbEru/4siYk5guulcIPRxHX7NU
 1dawd0maldeGmn4nrkHZj734ukarQNv0pvmy9ol3irQv01l1yN7ubmEFc1TxGbW5Bezuu6tfEN2
 S4EdOG2SwDZ3za90edBg7mX7w3X/VIOf+W2rMBkX6/CBAYIpolcKzvj+cvuAO/DPgmzY9PYkRe3
 BalbIsrzMm/JI0PqomBQABp3cXcEb7zUDHGASToqCicibWiaOlvXE2USl6BZvctR4YLCHC1yfSA
 hLCT39vcDzuTic9M+pneHGNd+KSmvmHD0ZD2bHdsyYreHgz4uD36IwhoY7ERjT3oVItF7kkJpRF
 nzdIH+8o40RIkPJKQyY2n67x68pFLOZ3cOCy6QQbIKe24yagdYuvhLcF4VeQR7r1vSh4XkXE0RG
 oyWmLe5MO8YuUBGj9GQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

