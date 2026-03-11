Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52128FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsM-0000uZ-V3; Wed, 11 Mar 2026 00:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsB-0000ot-4U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0As9-00005C-Mc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AKZ4cg1863226
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +uVDGq7dJHTrOrLyDMjlzrACmQcLWLNq2nBzhTxQpEs=; b=dUC4JZerKJTLEgpV
 Xs+oAhYgEfzpdiBnq7MqsICauKzRUntJs9RuXvxiSh4ZvsPg97dQAjtWhndDERMP
 oHe3u3UcEZfz03Enotapl/KOQ9dc/bZuVEDEG3M1pteLvBlXl0Pi7gokOgHXTbB0
 5GjukZ1ZoNNZhJRsaAuam1E+fyUWp5xYMP4u9ZIb9RC3l40QwpULAmiWzr59Qc7X
 0lfBr7GQEFQP3Eo4PMXpWLpmKt+hczNlGgQ08/CmuIrvlRhiHbduBOQSRDhwLwKE
 8i2vsZif//kAXh1kkdDQI8z0UHKTTmJZp60+9uJ753Ryb7TlRXRyk3qjZu31pWyJ
 huuzDA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw82q2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:36 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-415e1e9aa5dso63638865fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202115; x=1773806915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uVDGq7dJHTrOrLyDMjlzrACmQcLWLNq2nBzhTxQpEs=;
 b=ijv6U4mc3GIbGU/39om6/YkHu/E8aUyr3NMXYS2cve22aTnWXQpAYStczfOcAdyVru
 gdCrurXhLJXugM5AlU4XtCy6+pwskcwB1E6bcvkAtyMB4O9rtrStpXnQaHCo5mRohV2A
 +Z2WgbrVxR2CBf4+/dmNQz9rTPpIBm/RVQXSpeBRxmpuBjTPSEmfGscKeBBpMj3aC0uP
 hD+F1y8MUNebNRS2GWwwyc3QnMwlvo26h7QtsqazRMMn/ilqM86WelH2ys/ieYV13pMB
 5OMYGr36G/SgCjGHHe7L9UztM0cjkA/6f9wn2IohX2lUGYmioB9ByHbMOnFnlz+RHK7C
 fOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202115; x=1773806915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uVDGq7dJHTrOrLyDMjlzrACmQcLWLNq2nBzhTxQpEs=;
 b=cyw/2t45MN/LzwrU1x/V2mtyugyDkUdTdmz+60hIXxlOcrnzyJhfnagDK7Ivc9rle1
 PIJ7PNxOPid6BO/XHUOPHoeOYRATs4BU7sgD7FF7ya6+smv0HywInIB2D56M17LSZOtt
 22nK6F7zvQ22iiI375+KLkzdi/kZGG5yHBLKH+6xbVKzEZEaU8yS8gEI9eae8Icx/+Ui
 nSo6dTosCGj+t/3n5pMgs5Sn8/JHAVzo69nUZdMrF8MAwg4cK06nUq230Hkw8VyeDSco
 uucDmvNggGlqJ80qmJ3gWDukLRCtkhFkt2mB1XgkpqpwiWU7J5Upg8tdo6fma7AM4ckx
 1zDw==
X-Gm-Message-State: AOJu0Yw7VbNuOtoXASjnvi6F++EQkbkXDSes8hizDdXUicC9b7dwzPEk
 GuUrLTp5LclqcOyb04DUgGZycyFonR4ybi95SyCdxEQt1fuhcyCUtZWKQCYzk2QdkU9jV4xLN00
 r7cBYkGjxHl+n0Nb4GOSxRmguB8wZhpaLxFcJSV1JHLD9sDXsYKq0NrXe9BOOGbwAfw==
X-Gm-Gg: ATEYQzzNVZjNpKkcjGXUyOV7CyVuckcchf24yP+BqgF1rF2txi+GvI6F1Nl5Gf9GKEJ
 Ehk/5XfUVPNXotkYBiw1x9Ym3gS9XvfzSmHxbCz5fIHyZ4I2ID1n58zc+XiFDGBFonldBsB2bh3
 fiX2+895tu3Eh6f87xc+jXcTVEM8OOAiDZk/8OyfBhueYdRuJVNl/eNrT/2o5i4RN6RaC4hLz09
 tRrBg0ltpdLQcpJJ4BUGr1tpq9465dLUQGuBOjEr8EuieHIw8RNf+VhroH2Ucn9DFdsky4Yul8t
 /5j53C0RuO+VAkgAJZwCuyQXhZNpk3/Y2vcb2KcP2VOL6dh74g2aTfFlCC480wHdMsM0pdvPDoN
 haQ40lnuvvN2OP7IKVAFxS6eOflXnCvcazUfu1tL5o9yk3Q+aS26xUZM2VW26Z7QuhuSiHA==
X-Received: by 2002:a05:6870:2e04:b0:409:7cfc:7392 with SMTP id
 586e51a60fabf-4177c96b888mr947324fac.42.1773202115468; 
 Tue, 10 Mar 2026 21:08:35 -0700 (PDT)
X-Received: by 2002:a05:6870:2e04:b0:409:7cfc:7392 with SMTP id
 586e51a60fabf-4177c96b888mr947314fac.42.1773202115123; 
 Tue, 10 Mar 2026 21:08:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 21/32] target/hexagon: Decode trap1, rte as COF
Date: Tue, 10 Mar 2026 21:07:47 -0700
Message-Id: <20260311040758.1068731-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: HNqwCkXQfhm4L0fJcYEUuTnYwWAfFmHt
X-Proofpoint-GUID: HNqwCkXQfhm4L0fJcYEUuTnYwWAfFmHt
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0eac4 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX9nt8/Usav2Fv
 ct0DX+Y6HbI1ngU7aPhA7HUPXjk6EFtJobHI8HHm3HaoWsU8dS1z5N1+tWEc7fgxqxEx8cEIm9n
 cX/eDfTypAh2ezs7r7Qz193uLBREWlQRl+0WMaYdOKM3yV8iVbEnT9NkjAwIloFA4AAAyjaE1gB
 SC2mguKjNONGAXM9gto0Xa8TV3hqloWU2mKRLXlEKqrrF8dn5+LrzT+JKCQJ3p1Am8PNr89Y3Jw
 J8sEYZQm9wvw+t3UCeS7PpUkXFxEGBppahCt/tNGsxnHCXYKLYKFpRCcB2ZFzlmLwwr4JfJ2Hs2
 JxOq9btuUPtyYbRPJpYbmM+0z6WvUSaqfMo4iMKBUxgD/E4tcC6JzoJbtBLOhGp7kPSi0iPfko1
 FWHpMm0NH9UjFi1zEzJMTRVxj6AX4v2Wawu721EnAUzRbdi4gfGLrOdyHDZ+IMhGz7ribiFCEhK
 PuBtJh2cBIIFHyRIjAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgoKUmV2aWV3ZWQtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9k
ZWNvZGUuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFn
b24vZGVjb2RlLmMKaW5kZXggZGJjOWM2MzBlODIuLmNlOTNlNmJkZDhmIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAt
MTg1LDYgKzE4NSw4IEBAIHN0YXRpYyBib29sIGRlY29kZV9vcGNvZGVfY2FuX2p1bXAoaW50IG9w
Y29kZSkKICAgICBpZiAoKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0pVTVApKSB8fAogICAgICAgICAo
R0VUX0FUVFJJQihvcGNvZGUsIEFfQ0FMTCkpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfdHJh
cDApIHx8CisgICAgICAgIChvcGNvZGUgPT0gSjJfdHJhcDEpIHx8CisgICAgICAgIChvcGNvZGUg
PT0gSjJfcnRlKSB8fAogICAgICAgICAob3Bjb2RlID09IEoyX3BhdXNlKSkgewogICAgICAgICAv
KiBFeGNlcHRpb24gdG8gQV9KVU1QIGF0dHJpYnV0ZSAqLwogICAgICAgICBpZiAob3Bjb2RlID09
IEo0X2hpbnRqdW1wcikgewpAQCAtMzYzLDYgKzM2NSwxOCBAQCBzdGF0aWMgdm9pZCBkZWNvZGVf
c2h1ZmZsZV9mb3JfZXhlY3V0aW9uKFBhY2tldCAqcGFja2V0KQogICAgICAgICAgICAgYnJlYWs7
CiAgICAgICAgIH0KICAgICB9CisgICAgLyoKKyAgICAgKiBBbmQgYXQgdGhlIHZlcnkgdmVyeSB2
ZXJ5IGVuZCwgbW92ZSBhbnkgUlRFJ3MsIHNpbmNlIHRoZXkgdXBkYXRlCisgICAgICogdXNlci9z
dXBlcnZpc29yIG1vZGUuCisgICAgICovCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkK
KyAgICBmb3IgKGkgPSAwOyBpIDwgbGFzdF9pbnNuOyBpKyspIHsKKyAgICAgICAgaWYgKHBhY2tl
dC0+aW5zbltpXS5vcGNvZGUgPT0gSjJfcnRlKSB7CisgICAgICAgICAgICBkZWNvZGVfc2VuZF9p
bnNuX3RvKHBhY2tldCwgaSwgbGFzdF9pbnNuKTsKKyAgICAgICAgICAgIGJyZWFrOworICAgICAg
ICB9CisgICAgfQorI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkCi0tIAoyLjM0LjEKCg==

