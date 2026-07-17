Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E58C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2f-0006rR-U3; Fri, 17 Jul 2026 15:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2e-0006r4-Pz
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2d-00086b-8u
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGobUm2478561
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 My6IW5fffRJRMezR/GjObKT6jUGTiTD+1poE1sgWj9w=; b=WrQSoesB2OvACwoa
 /8ej8hcwPThVqSnyNEYR8tfgV5YPpSUfylhBIgxlW9bWe7cZsWf97+qwXhhMXl+L
 R0JMFifMgPkwLEt4CBkkQ5Ve7+D4Kxim7Xreld842jmrAoJq1ynxHklxFNTivPJ/
 wX0rQM5lIW1wuTBPQMYxo7psyFk/X6MsxPqHDHww2ddQSm9XeSnhOpETl0+dJOuz
 jqvF24lT8VOiaE/LQtBRpvxnUyacIpv3qfSdNinaRKbfURUPW8U41FET3TwUqkXj
 SqhZr8cknEhAMhYjxp9nWjpKOxKmbaYZ2YEhZRD23zjqO2cx0br5x8OZ6N/EAcav
 b6awHQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfjb27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38de842a1a9so7735429a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315769; x=1784920569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=My6IW5fffRJRMezR/GjObKT6jUGTiTD+1poE1sgWj9w=;
 b=gphKpb49WSOuSfoTfM5YsuMDIJHv3+VWyU4t9yY/9R1vD7yVI9bfruNb90IiIkbXt8
 qCqjLuFkkLr7/fRNYr/7a35x1Fv+PMCoY08JTxIstat6s4O7JtQR+Bx0lMNwRmfabcWy
 oi5mrWGHX7fuEK444OF3Q9yWZo0cgoHK8Hgb3mKAnV5pyF1M2ZMnw4FypE5AWe4F0rnm
 jbGBbUAIMM9ePUsdjPZ5hVm5azKeErtMqohkbZvuJ4qRDObnqTxhBKE/TMvgKasScLPt
 NahQ4PU9Q3cO9BxNgdv6u+LtNS+1pvP8REwpb71wxxy5CcHfoShu2wfpJ3uA/ySnAxR6
 5WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315769; x=1784920569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=My6IW5fffRJRMezR/GjObKT6jUGTiTD+1poE1sgWj9w=;
 b=GMgsRNLHVGXrnx+PZxL9T6J2Kg6XMOoLU1iRqiFOgl3STB7UUvhtKZZr/CFMgWyj2x
 Ah2Jh8KTDFpWghmc4OVcXUCnYkCTKRoDXAXz5d1eU/VwCteQVT3og6q81kMPGVJwG2hM
 T3Vi1opbkNBTMzPU4X7P91zfRD6GxOo1OkQruq7hx5HiaS+fFFF5YqFlz2JhDDqTb4SP
 rKTxCirtoNBET6rXj/M78Zp2kMEz+4Kpd9bTSLkozTOEZncxuhsznWlj+TDNbtHnMzwe
 pErEQWfhoO5cZgDPXmeNsjC42B2I/nB9YqI4eqye+AWFHMPdd0DYccgzEyCoNraIT6QN
 48fQ==
X-Gm-Message-State: AOJu0YyulYRkttfeVjp2sQUDp8aQlPloE0yNTJcFOpyExusNe1OUsrEV
 pH+VGwCuwDZSG99OweG0GD2eZh8JS96TsqwK+30mQCNes5uq9Z1g4R9uG/dPcuXCkDYbptU3pz5
 1L0o7MbZFu91Mt8mfewAdbRsmLozB+DGCsgDVaE6KmFef2sNly/Qs8KkdSpnC1lLqIA==
X-Gm-Gg: AfdE7cldRYsjwZSnK1wO6ruT0H+mwNolZc0FNIOeceZXRA8++FTOkvDl5vbJLFQ1Ni7
 YjlEirLg2uSOYz58O/+iZfFPewEmVuvoqOoqb4G0pwF4rdzk64cUAV5gooDmWMlVD7f7XsI7/tT
 OkJ9HJORTYDLyulpA0egN5RpIA63g6uEDeEfIf2wpYepUzfGVXLMAihKGZR+6eQ46LPC/TNAfHG
 gPafmoxbUEq9OxwZYx0VfZ8mnWSYQ5nOaiGj9a6h/NmW/kfd9K5xzC8NPz6tbAIdYPhnf3jm7b0
 AVgXnw7ZUCFaWBIenBalgizO8GIyp12wt+ZAgFFu+X9Gry1Zc7PR0VIz2VN4s78aRaR8xxBlpLA
 W/5MiZ66CmvqG1LN5I1pp9LjZLGutjKexDwqMzMJ+6lUaeDtX
X-Received: by 2002:a17:90b:574c:b0:387:df8f:1401 with SMTP id
 98e67ed59e1d1-38e4b57df01mr3910399a91.34.1784315769417; 
 Fri, 17 Jul 2026 12:16:09 -0700 (PDT)
X-Received: by 2002:a17:90b:574c:b0:387:df8f:1401 with SMTP id
 98e67ed59e1d1-38e4b57df01mr3910351a91.34.1784315768774; 
 Fri, 17 Jul 2026 12:16:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:16:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/12] target/hexagon: initialize deferred sreg-write temps to
 current value
Date: Fri, 17 Jul 2026 12:15:45 -0700
Message-Id: <20260717191547.920048-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX5XUnGQunjCwJ
 c3AREock/jdNo0i1jWO7n9DGjmPip4GdJSgaxaGeL4I8N95oGkBtPPAkITtrWroH7MmCEX2R9i9
 dcHU9najHla0DjjjUjDzM8I57xfGl9VZP9ognDZPhk8hHYa2Lwdm1cjN/0EK0bVL/W3kprtveuw
 NWGkL6DMwMFHqL1AwdkthwTCGhZrWQ3rLw8bg+YGLPnAc15zDFN8/zYokQdHiZE/FXnMMi1O+i2
 2oBpE2a7N3DJz+q9VpnH2arD4EXHI1VFz/vFVUPoTF0NROyE9+ks/jW2Ql4HtomcIUr3y4cR6nI
 E+7xiGd5s/Hg/+dug+Wlr05Cbl5/rufwVdCluBnxdek64XTALIWnkSzZamTWoCOcPpbthMOVsuy
 O9zT09md4i8yInatA2pirKXrcGq5hJW9KhbpvCD31APGaLimHY1zegUTnbiqEexnktO3eQYxrfp
 cxEPOEVZq0ncLRqClkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfXwYiNBMe5rwJh
 VuWYO63TwQ6DCgdmTa8DVuxsjiAx/sq44cgHgdnUjte8IAE4mf0MgjnyCX/vlGlM7q9qxskkX0V
 luwuSD4eMpJClOj5I1Mhmxnoqk84+h4=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a7f7a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IlOZXNdbeIrMSDKviAkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: vP6pZhin4ESS8B6F5QKbt4k9lOy8sQtp
X-Proofpoint-ORIG-GUID: vP6pZhin4ESS8B6F5QKbt4k9lOy8sQtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

VW5jb25kaXRpb25hbGx5IGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSB0ZW1wIHRvIHRoZSBz
cmVnJ3MgY3VycmVudAp2YWx1ZSBmb3IgZXZlcnkgbG9nZ2VkIHNyZWcgd3JpdGUsIHJhdGhlciB0
aGFuIG9ubHkgYWxsb2NhdGluZwp3aGVuIG5lZWRfY29tbWl0IGlzIHNldCBvciB0aGUgcmVnaXN0
ZXIgaXMgU1NSLgoKV2l0aG91dCB0aGlzLCByZWFkaW5nIGEgZGVmZXJyZWQgc3JlZyB3cml0ZSB3
aXRoaW4gdGhlIHNhbWUgcGFja2V0CmJlZm9yZSBpdCBpcyBjb21taXR0ZWQgY2FuIG9ic2VydmUg
YW4gdW5pbml0aWFsaXplZCB0ZW1wIGluc3RlYWQKb2YgdGhlIHJlZ2lzdGVyJ3MgcHJlLXBhY2tl
dCB2YWx1ZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDUgKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYwppbmRleCA1ZDU0Y2U4Y2FhNC4uMTE1YjY5MTI1NTMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBA
IC02MTUsOSArNjE1LDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnNyZWdfbG9nX2lkeDsg
aSsrKSB7CiAgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKLSAgICAgICAg
aWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQgJiYKLSAgICAgICAgICAgIChjdHgtPm5l
ZWRfY29tbWl0IHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSkgeworICAgICAgICBpZiAocmVn
X251bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgewogICAgICAgICAgICAgY3R4LT50X3NyZWdfbmV3
X3ZhbHVlW3JlZ19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgICAgICB0Y2dfZ2VuX21v
dl90bChjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0sCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIGhleF90X3NyZWdbcmVnX251bV0pOwogICAgICAgICB9CiAgICAgfQogICAgIGZvciAo
aSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkrKykgewotLSAKMi4zNC4xCgo=

