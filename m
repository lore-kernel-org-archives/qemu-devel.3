Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9181CC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH51a-0005NB-UB; Wed, 14 Oct 2026 15:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51a-0005Mx-6i
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51Y-0002UZ-Kc
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb6rc1013288
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OhV38KizTvCB5oj9YikPPLjyS9lzqqnGVCkz6fBZjTQ=; b=TXOCGFM/fxnzbMDn
 2L3QhVKBMZm5DVnwQFXXJJ5Ax1BZbW4SDCG6t3j3FF+xQuW9F9Ae3YlNDVtVU7Dz
 I+WXVjLUX8w6wIYVdaD86mfsDJLnZGfIp7DMAIF9RM2S8p0JT/j721rcf548RjNn
 uN2VVgVzm9OPEe3f3/nHqBmnHAk6oGELdAvEWo8f1T+SflB776lETN5XceoUAVfq
 jampRL2A6x4n1a9fKR0oo/Dq4S0H4LVdTl1cNV3oFIhMzdS/GBws9di9sdDa66f2
 xHUWFtzqVyNXFkfcuWmWMzOsZ7mP3O/b4r/ocylJpXEWFoLfODyrI7Bd5owaMe3+
 pUUsTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ct66k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3592749a017so1315628eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007547; x=1792612347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OhV38KizTvCB5oj9YikPPLjyS9lzqqnGVCkz6fBZjTQ=;
 b=PM1JFYgsJGQLTid2e4ehly/4kFvlquH/1mu0QNwvgFhlDa4I5vcp09XC6K5vhVdzwt
 YXACB1EdCXq++PPK1Csfj8ujSoKBILYWPe0NWaJiwg9QmQ4Ns6ms95hBz8tFUDts3HuP
 e4cTKRiAfi5FkUHer/AtQuLg0cjweGAd7GZrjcQ/+IcpWhLEKg1WrvLXMwR1B7fcSygM
 tQlL3lf0GsZLIUJ76vV1nO6/1v+KuxFlFuzyWUY6EzjcxhjqlkPaEqHJGX7iK5JhfThS
 d0eUqwpEnqaK+vjm+LONrpSWWw0+gHDrozyT97cI5FKnYqxlbnCnWLeqtibYjI3V2xI2
 wnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007547; x=1792612347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhV38KizTvCB5oj9YikPPLjyS9lzqqnGVCkz6fBZjTQ=;
 b=uVvPXBUyi5hOFhw+4NFPEIAiDFs1Ow8yojNYAmWRXiRhEwOhR8vv3T8FzCIO6pzs4x
 /GXGk1levUKaRT5tPcZyg3KI9ycxHkT9N7g49Byp6A8G1BuXFaBxp3IAgKC7DMCaLK5b
 YnGpVf7snIZpgIK3nkm2bnrcaxhJTU0b9xp9doPWK6cGqLRCsx8ehR6oXbowSioyJDvB
 btTdXF0fEvWAXgFoBqvTkxLyE/MiI72fS8+npukx4/gnTD13ZO7jKU5UhaUOqPGX0wHE
 8vtOEqo+PZWtX53qnqqV0wd9Lo1cBbqFuBd2qH449ytAdSfH+Ol5MTRJk7ysb8ePwtWt
 VH7g==
X-Gm-Message-State: AFq9FYLCWosP86NmEnK7Lp8eGoHhaIUP5ev5us/D/OHHRceKceL6Kc7d
 Lg6k/aaDNFhZTB0BHlt6/6yn9Y6r3yg/FiAoL9cqhQD4ajt5ebhT968GvjLQNtJCuKHYE+Sg03v
 IZQZJmsBznNUE56fYikf7EpMW1KeR6oiFIG9t6ME4TskzAOSFqVWsMm333M2y6R2/RQ==
X-Gm-Gg: AYBFou1BKUx5Kz43kKtZdRk6+VeNSI46r+t6YmH7VzYKjrLhi0UrBcgWFfd7N2Jb49s
 PR30n+PbME8/woOtMF4g8D4OqTr8k3f+Fnnix2VIy54LWqAf+A2HDSH5XSEwcUR+R/lHjqM0Dk2
 Zw7ziYfpqqfghTdwGx7GhMVKIAvCQ3LXfu41yFd9NN1PQ7D931liX7OEtMGVCc370F5k6//pR/V
 Oe+CJaZHuAosfLUKNQZy4ZKc5ywfhqbOI4dmBAavn2eiCyPJsxekAfxhh7aYFiSi21SCXISy4OZ
 dBzgp1AR5uClSq4dp1yngwOsSjVW2DxrvbSVwGwTrrr14LcRuZ/A1OVCr6jYBRocDI7McWoeBsx
 vz0hcmrP/nwQISk4W1O75oz896pAG0w11Gw+3vsWxdhxc+Lo=
X-Received: by 2002:a05:7301:2127:b0:359:27e6:b684 with SMTP id
 5a478bee46e88-35927e6b814mr16268597eec.3.1792007546473; 
 Wed, 14 Oct 2026 12:52:26 -0700 (PDT)
X-Received: by 2002:a05:7301:2127:b0:359:27e6:b684 with SMTP id
 5a478bee46e88-35927e6b814mr16268573eec.3.1792007545940; 
 Wed, 14 Oct 2026 12:52:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm547069eec.7.2026.10.14.12.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:52:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 01/12] target/hexagon: sort tag_rev_info entries by version
Date: Wed, 14 Oct 2026 12:52:12 -0700
Message-Id: <20261014195223.3233623-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX4c0/vbY27Mme
 fH2uHc4Y7cXv4Uc5+NIVAOEaeamhjDGbvPFYhEmQjFS0Jw72K4mlONEvqF1o1asDMyPqsFeOsfC
 nz+GB4f3jMMrFP2wJO2PJJosHBRTJ7o=
X-Proofpoint-GUID: T250_v257wqQDl752qsC4U3k_V0t3ilp
X-Proofpoint-ORIG-GUID: T250_v257wqQDl752qsC4U3k_V0t3ilp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfXxJVk5Wf7sHt5
 gTdlwlQzZQFyrAh8Lt3FT3ws1N0Lac+RwdlX2O/1C1Hb0B4PZ/b9kcmtQMMaNQkIbmVv6y750K1
 B8lTuqHCAs8UrNqq7WxtnsYBTtqt2sKs8PgjxwkdvchYQxIwInnawZcdnOi0IGGIdPOHZtbOpQq
 asP4YsumG8cXGKzSLOadPtdZ6X7MObJuBJMCbyw/VcK7fhTLCjPHs6/+5EcN49SAP1ZIOHaqhJN
 AUbCzfTib/hX9ebiEYux3iAWMAGv6dWyqjPBPbio9z8yuZwtQPDEGdzWJCsVwOMYYz+yIkzJdwF
 nVfBGVf3HdaflFaMjtCmnOzyKrG8XAbd0chnwg6TdZa7WEL8je3BUhn6pXohuj1FQuGWxEleYKq
 GYUebHVa8Kv/DUBIkppIFEXfmV34qiDWLbc40JF3LnLdYhoJj55RmcMOqajdhsav45hRdYwPf+e
 wFz+90feKnB8j8WmwQA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acfdd7b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XH382VzwAMdzo9DkozgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140079
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

VGhlIFY3OSBRRmxvYXQgZW50cmllcyB3ZXJlIHBsYWNlZCBhZnRlciB0aGUgVjgxIGVudHJpZXMu
ICBNb3ZlIHRoZW0KYmVmb3JlIHRoZSBWODEgYmxvY2ssIGFuZCBncm91cCBWNl92Y29udl9iZl9x
ZjMyIHdpdGggdGhlIG90aGVyIFY4MQplbnRyaWVzLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jIHwgMzIgKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmlu
YyBiL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYwppbmRleCA0MWNlM2NiNTcyZi4u
YjM4MGE2YjQ0YWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmlu
YworKysgYi90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKQEAgLTY0MywyMSArNjQz
LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0YWdfcmV2X2luZm8gdGFnX3Jldl9pbmZvW1hYX0xB
U1RfT1BDT0RFXSA9IHsKICAgICBbWTJfZGNmZXRjaGJvX250XSA9IHsgLmludHJvZHVjZWQgPSBI
RVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbWTJfZGN6ZXJvYV9u
dF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05F
IH0sCiAKLSAgICBbWTJfdGxicHBdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVt
b3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotCi0gICAgW1Y2X3ZhbGlnbjRdID0geyAuaW50cm9kdWNl
ZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFo
Zl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05F
IH0sCi0gICAgW1Y2X3ZlcWhmX2FuZF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5y
ZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCi0gICAgW1Y2X3ZlcWhmX29yXSA9IHsgLmludHJvZHVj
ZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmVx
aGZfeG9yXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVS
X05PTkUgfSwKLSAgICBbVjZfdmVxc2ZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFzZl9hbmRdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92
ZXFzZl9vcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZF
Ul9OT05FIH0sCi0gICAgW1Y2X3ZlcXNmX3hvcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9W
ODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCi0gICAgW1Y2X3Zjb252X2hfaGZfcm5kXSA9
IHsKLSAgICAgICAgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVS
X05PTkUKLSAgICB9LAotCiAgICAgW1Y2X2dldF9xZmV4dF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVY
X1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1Y2X2dldF9xZmV4dF9v
cmFjY10gPSB7CiAgICAgICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0g
SEVYX1ZFUl9OT05FCkBAIC02NzEsNyArNjU2LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0YWdf
cmV2X2luZm8gdGFnX3Jldl9pbmZvW1hYX0xBU1RfT1BDT0RFXSA9IHsKICAgICAgICAgLmludHJv
ZHVjZWQgPSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUKICAgICB9LAogICAg
IFtWNl92YWJzX3FmMzJfc2ZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92Y29udl9iZl9xZjMyXSA9IHsgLmludHJvZHVj
ZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKICAgICBbVjZfdmNv
bnZfcWYxNl9oZl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVY
X1ZFUl9OT05FIH0sCiAgICAgW1Y2X3Zjb252X3FmMTZfcWYxNl0gPSB7CiAgICAgICAgIC5pbnRy
b2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FCkBAIC02OTgsNiAr
NjgyLDIyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZfaW5mb1tY
WF9MQVNUX09QQ09ERV0gPSB7CiAgICAgW1Y2X3ZuZWdfcWYzMl9zZl0gPSB7IC5pbnRyb2R1Y2Vk
ID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1Y2X3ZzdWJf
aGZfbWl4XSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVS
X05PTkUgfSwKICAgICBbVjZfdnN1Yl9zZl9taXhdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJf
Vjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorCisgICAgW1kyX3RsYnBwXSA9IHsgLmlu
dHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKworICAg
IFtWNl92YWxpZ240XSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBI
RVhfVkVSX05PTkUgfSwKKyAgICBbVjZfdmVxaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJf
VjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92ZXFoZl9hbmRdID0geyAu
aW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAg
IFtWNl92ZXFoZl9vcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0g
SEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcWhmX3hvcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVY
X1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcXNmXSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAg
ICBbVjZfdmVxc2ZfYW5kXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQg
PSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZfdmVxc2Zfb3JdID0geyAuaW50cm9kdWNlZCA9IEhF
WF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92ZXFzZl94b3Jd
ID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9
LAorICAgIFtWNl92Y29udl9oX2hmX3JuZF0gPSB7CisgICAgICAgIC5pbnRyb2R1Y2VkID0gSEVY
X1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FCisgICAgfSwKKyAgICBbVjZfdmNvbnZf
YmZfcWYzMl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZF
Ul9OT05FIH0sCiB9OwogCiAjZW5kaWYgLyogSEVYQUdPTl9UQUdfQVJDSF9UQUJMRV9IICovCi0t
IAoyLjM0LjEKCg==

