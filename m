Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E7CC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2UK-0007KM-LF; Wed, 12 Aug 2026 02:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UE-0007Il-EA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UC-0003sY-3M
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62AqW4090980
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W6c6LZ+jwSWDITdL6eA5pVfUOXy66bHnIoas/zO1RfU=; b=NyjBTqefh9sUC2V5
 nLqe8Ki9cUnx0KV2vj+CEOHV/Ty76PrsFkcbQe8mFkYFGunfcwFsdTzTjBz9CHRH
 nD+LybuKexhvn9q72nwIo6TYLesL0h5Q10D9Q+sOmBxUMUsI1ga8aS9OG9E8L19c
 9udTGS6rzzQOFNrYh64itMTjYtS9E510Y3RyU0cyMwEAiKuPoLmamOVGo158tAKD
 a65Rc9XtKLLgDFKJEuDjRZkNK/Q+8hS6kn0TAGG/y89OLdUjtiDbTZ4IXRRo9JZ4
 yJeZrtQVVxM5a+X5godoL//+1Tr5OAgwQPKbs+JQ8q369rpp0KU1M7NaU4QiCbe7
 Agb/SA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049buttw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbee57593baso301741a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516244; x=1787121044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6c6LZ+jwSWDITdL6eA5pVfUOXy66bHnIoas/zO1RfU=;
 b=kHkkxikswJm/C228FCiK48I88W9Y1Y3oknSAWBno+Nuh58PtRpXqNxDWn+frEDzyJm
 4kEnlKaSRjrsjsVqlEVFVtYOJvuepCN/RK3hOSAy8ttdvvnFknESj228aQuwFLn4OLlf
 LJMwMqvEQGs+AMJcWl6Y07nCyonXackbQglRs0ThOGBEc10mA7cESETQstg73z7ouKFK
 E4AEuFlyGyplh0z1+G9NIVA8NFLft6B566j5JHVlDzUSaeMOPKMgoQEmO1bpw805bbqx
 S7tV9b6l/kEnO4RgRJPPXFkeU8fpwgktZoCaEU5f8ge73T85ZZgf2x5tyC92pQHdsYNP
 GoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516244; x=1787121044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6c6LZ+jwSWDITdL6eA5pVfUOXy66bHnIoas/zO1RfU=;
 b=h4G3lpuFnuXG6TkUYKFcTIz0B0es9dCewzY55T0m5reGoQ6+QCufwCj+MNl/UZlrcx
 mQi0aIvfAJuSw5OHAt+n0Zg/3UcOh887u3TweKe/T62JBf5WC808SRCvnTLu6BSkZsLr
 BJZM/TYtGeJTF9GY2UtlfsYzYdTSa489eH1TpZ81YyDb3VNWcoEOwPphcdJFKb6PQvF4
 HrIX9zz3NzzvH7erQwKeZUA2XfQg5872y4BVuQ/twmC7KCf6k5/KTxPFKw9jbiRJPsPO
 U/gTaYHiJbS0pPpz6jTdQh0WyDA+M/wdp+JKwA9k8fhET/pemE7sIex7s8iH/dg6KaUx
 U/Rg==
X-Gm-Message-State: AOJu0Ywq56XzII1n87OuwpiMIhYTU2EdVCw1biHjYR0mNIpSWq2ianGI
 TJSNAyY0pBsO+iH/0SpfB3F3D7snLn/KYajVk9VTW2mABzpEKUjFPP14CPzCbDptN3Aa7g3GXEy
 qpCPDZlUyyqtnVa2DBUxue3eIvY5UBNM1AJT/6E/w0LbOHQdQLA+qYNgQfVxWIomN4A==
X-Gm-Gg: AR+sD1383TGF6tQTQwdsqvuw4xd52tbXBuwtCCzmHix5dCcIikIvsThU/LY/RwEpSxc
 6X7hyxFHZFX5b43mX95NfuOieQcrGUNbQXIRlh8z/btXrFceWbAfM35iZx/U3QqPzdhzq6uHNIf
 LGPfsbs1/Cwx3ex1UvrH+qVkYwnHjPP08JqFjLrQVLyRyvTzXrObBEBt0odOROgC7yTudSR3VZj
 268wDHcVlrdqwNAJt9+y9mu7sLSULhbnAgFPcFq2ONRXk3JeqP0dCEe7GO6eyEbiDDkRa0lMYhl
 9lGv1jvJM3QoQvxE04A0ccYgajgyk+okT8GguEHLo0lMClTJk8WOXuHoT4dBVOIPpvQLpBgHNm6
 9d5RPgvwwn9tzjRt2s3h3L/s3RRamUB/71xJmUKW1pXhy2xSN
X-Received: by 2002:a17:90b:4a4e:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3930123e90emr2678324a91.3.1786516244223; 
 Tue, 11 Aug 2026 23:30:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4e:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3930123e90emr2678180a91.3.1786516242372; 
 Tue, 11 Aug 2026 23:30:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 25/41] tests/tcg/hexagon: add HVX tests for vabsdiff
Date: Tue, 11 Aug 2026 23:29:16 -0700
Message-Id: <20260812062932.543840-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: sUkZIdSfusVeGfrrHj7MVIChie709Su3
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7c1315 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BpNi1cdwbXwK4F8ztrgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: sUkZIdSfusVeGfrrHj7MVIChie709Su3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX6Eau/Qo+eaTG
 qei5CfRQe2cy/nnl7spmhJYpjkDAGxErpbtnIf4ZJSlZFDotCca9pvWbj/1sB7IvzVl4Qwpq08L
 RIuO64vWade2uX+y7OQLNTANm1t/BdE4d90uSDa9XuhGoFp6HIQ0CnrdXo3ZFag2NLbkEr4x9Xw
 i6vH1cK9yShSuzNNgMJX3tcmYrA9X63CnuCcpE35DRA6lmVLbQ8IwwL0gD2me49DIcd+tH1N7Qg
 dtDORyEvEJf6XalmX4CQKOuvUUhw3S9Vprgbaot1PYhZzue47x7YbOgl+mEFNCTBWKGgeB0qpJ4
 5bUPp+zYB27ZtEEdHJnkSUJSQhJOF8jneRI1Cc3TCg0LpkFP1dpEKPMjzhBVl4ndloCcRVYYwrX
 oEm0aVsDP2Yl8y7CjwWP46SKOTphBrv+Bl19AuZUL84JoMiQODnHlEuQolkSN3b/Wk8R+DXhs54
 oQjft6wFHP+pcMsaUOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX5JzXRFMaWEJg
 za4D/rrgWl7ZuYHk8kJWZkO0KpdTquKLIx4en48K8mdZBlp+gGBM71UC5sUQWbtORXVxIjWTYGL
 7NrzLGadGid1Xwsbfo3Wo3UtcEg5qRg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
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

Q292ZXIgdGhlIGZvdXIgdmFic2RpZmYgdmFyaWFudHMuCgpUaGUgZXhwZWN0ZWQgdmFsdWUgaXMg
Y29tcHV0ZWQgaW4gaW50NjRfdCB0byBhdm9pZCBvdmVyZmxvd2luZyB0aGUKc291cmNlIGVsZW1l
bnQgdHlwZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QG9zcy5xdWFsY29tbS5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjA4MDcxNTIyNDEuMTU3NjMzNC04LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDMzICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIGIvdGVzdHMvdGNnL2hleGFnb24vaHZ4
X21pc2MuYwppbmRleCA2NDFjZmY1OWFiYS4uMzJhMzY2MWE4NmYgMTAwNjQ0Ci0tLSBhL3Rlc3Rz
L3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2Mu
YwpAQCAtMzE3LDYgKzMxNywzNCBAQCBURVNUX1ZFQ19PUDIodmFuZCwgdmFuZCwgLCBkLCA4LCAm
KQogVEVTVF9WRUNfT1AyKHZvciwgdm9yLCAsIGQsIDgsIHwpCiBURVNUX1ZFQ19PUDEodm5vdCwg
dm5vdCwgLCBkLCA4LCB+KQogCisjZGVmaW5lIFRFU1RfVkVDX0FCU0RJRkYoTkFNRSwgSU5UUklO
U0lDLCBTUkNfRklFTEQsIERTVF9GSUVMRCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIENI
RUNLX0ZJRUxELCBGSUVMRFNaKSBcCitzdGF0aWMgaW5saW5lIHZvaWQgdGVzdF8jI05BTUUodm9p
ZCkgXAoreyBcCisgICAgSFZYX1ZlY3RvciB2MDsgXAorICAgIEhWWF9WZWN0b3IgdjE7IFwKKyAg
ICBIVlhfVmVjdG9yIHZyZXM7IFwKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IEJVRlNJWkU7IGkr
KykgeyBcCisgICAgICAgIG1lbWNweSgmdjAsICZidWZmZXIwW2ldLCBzaXplb2YoTU1WZWN0b3Ip
KTsgXAorICAgICAgICBtZW1jcHkoJnYxLCAmYnVmZmVyMVtpXSwgc2l6ZW9mKE1NVmVjdG9yKSk7
IFwKKyAgICAgICAgdnJlcyA9IElOVFJJTlNJQyh2MCwgdjEpOyBcCisgICAgICAgIG1lbWNweSgm
b3V0cHV0W2ldLCAmdnJlcywgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAgICB9IFwKKyAgICBmb3Ig
KGludCBpID0gMDsgaSA8IEJVRlNJWkU7IGkrKykgeyBcCisgICAgICAgIGZvciAoaW50IGogPSAw
OyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gRklFTERTWjsgaisrKSB7IFwKKyAgICAgICAgICAg
IGludDY0X3QgZGlmZiA9IChpbnQ2NF90KWJ1ZmZlcjBbaV0uU1JDX0ZJRUxEW2pdIC0gXAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKGludDY0X3QpYnVmZmVyMVtpXS5TUkNfRklFTERbal07
IFwKKyAgICAgICAgICAgIGV4cGVjdFtpXS5EU1RfRklFTERbal0gPSBkaWZmIDwgMCA/IC1kaWZm
IDogZGlmZjsgXAorICAgICAgICB9IFwKKyAgICB9IFwKKyAgICBjaGVja19vdXRwdXRfIyNDSEVD
S19GSUVMRChfX0xJTkVfXywgQlVGU0laRSk7IFwKK30KKworVEVTVF9WRUNfQUJTRElGRih2YWJz
ZGlmZnViLCBRNl9WdWJfdmFic2RpZmZfVnViVnViLCB1YiwgdWIsIGIsIDEpCitURVNUX1ZFQ19B
QlNESUZGKHZhYnNkaWZmdWgsIFE2X1Z1aF92YWJzZGlmZl9WdWhWdWgsIHVoLCB1aCwgaCwgMikK
K1RFU1RfVkVDX0FCU0RJRkYodmFic2RpZmZoLCAgUTZfVnVoX3ZhYnNkaWZmX1ZoVmgsICAgaCwg
IHVoLCBoLCAyKQorVEVTVF9WRUNfQUJTRElGRih2YWJzZGlmZncsICBRNl9WdXdfdmFic2RpZmZf
VndWdywgICB3LCAgdXcsIHcsIDQpCisKIFRFU1RfUFJFRF9PUDIocHJlZF9vciwgb3IsIHwsICIi
KQogVEVTVF9QUkVEX09QMihwcmVkX29yX24sIG9yLCB8LCAiISIpCiBURVNUX1BSRURfT1AyKHBy
ZWRfYW5kLCBhbmQsICYsICIiKQpAQCAtNTc1LDYgKzYwMywxMSBAQCBpbnQgbWFpbigpCiAgICAg
dGVzdF92c3VidXdzYXRfZHYoKTsKICAgICB0ZXN0X3ZzdWJ3c2F0KCk7CiAKKyAgICB0ZXN0X3Zh
YnNkaWZmdWIoKTsKKyAgICB0ZXN0X3ZhYnNkaWZmdWgoKTsKKyAgICB0ZXN0X3ZhYnNkaWZmaCgp
OworICAgIHRlc3RfdmFic2RpZmZ3KCk7CisKICAgICB0ZXN0X2xvYWRfdG1wX3ByZWRpY2F0ZWQo
KTsKICAgICB0ZXN0X2xvYWRfY3VyX3ByZWRpY2F0ZWQoKTsKIAotLSAKMi4zNC4xCgo=

