Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B3C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphq-0002sa-DG; Thu, 06 Aug 2026 00:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphk-0002r2-Nd
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphj-0003DM-6Q
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763x2PM776166
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=12psgMGaE/AFAca7um5d5BHgu9y7A7ATuwy2bTUnMOM=; b=Yo
 jjClVNkK4KAVW4nYmTGW9bGPmpBEgLLmOWmVTKyekI4J8bHiqtHYgoadKatIgK9J
 Iw3kp0Fwa0CjkaSzFjwig6tWDphMq0p8IjFyr8PlO8c5XDEfH0i4UzAbqqpzqeJs
 Phcs2+8I6ZgEimgljVGhINyF0mM7KPN6hIVKQ7PsZwUb9xUXe1AA05MFs0prEbUs
 v6XYohYW/b5mvN9ROt85gHm0637hhR8/7JclZTimfatnvcD4Ggc0MK+kgrj2MDsN
 a/Vjmxc0e0e12Ifp/qqmV1HnYzY1CRiNIr2jQn1lbYcGZgzFTvxJ/u6Jk39V30Kc
 ze8xEz97v49fNQPHbC1A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8g34s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so1977677a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990457; x=1786595257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=12psgMGaE/AFAca7um5d5BHgu9y7A7ATuwy2bTUnMOM=;
 b=GVwEyMYwV1Rhr7JoSlNfQDXrAqaw/DnJ6lLaCqMpA/4BehF8KIr0G5zFTDpsVQvKMa
 9zoGOg+XfZ08RoVbnLHFEipzrN62zoUnGn3XbrUukwJDMVUTpRBF6jwNGtcBiu24CVrv
 xcw6CpywS6Kn7q3SuR7uIdwZbHXkeLBQzRxAk4CI1RX3IuVqyYkxTEjD9nsK641H7X80
 nBQsPKsZVnBfiHzMM+Bx7dVTr5AzigHM5rAhR0FUMiP8nfuNRj0pQfDnzb5N+MaQqkn1
 qS/4WrfYYvNbZ+SVUBRRnLYPLLYfZzEF9QM2l5qLtfjgTToFnadXJvmZRsYX1drmWN3/
 G23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990457; x=1786595257;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=12psgMGaE/AFAca7um5d5BHgu9y7A7ATuwy2bTUnMOM=;
 b=PPeuBhMkOAp7n7knYfAVlKss+kWEVgJ6RsDYEcYSj2o/+XHYM0JQCzHVYhXxrZ9m9h
 l5dXYz0/IGjMln2zJFmyk39637vhxspGwfEXV8owiIiRafToM9r6czMA31dABgnMBEAP
 02CmW5gYpRlC5splTJmHDQrdt+FeXOp+rNaFCyTiNpkdd4fq0ssu/MIrLgA2pAs4yfA9
 XkHFZK+W3nMOY0c5tQ7Joojczky+8vye0qnrEqs2OzyFDbBNCFHQz4GLog8KBTv04UoU
 96++og+k4BT2cfdO98xq9g0aRaaFmvZeu65Nonc7DmFDeBXs4IrgifPyyBmdp3E+cKnx
 7/gA==
X-Gm-Message-State: AOJu0Yx5GBceO037vS8QyDDt7LDoyW2pbQGHME1PY9LhROtO7A9TK241
 rlbQdst9w3u+iAJOCiYQjacEqzA50+4C9cdyfaknJjmkvohFdmYTGo0qT7WE3GRfs7oUOZcV8AK
 PemBP20yvrGsoYsqk6sriR6rqBY8n881CK+ysSYIiLbxNDX3fR9R8T1SUJLytIWLndg==
X-Gm-Gg: AR+sD11Xspkz9YWW8aQdQkyMB/S0ikwwA88VAcmx8tJIuEy3ojLywBe1kPvjm2fM/BS
 Wnw94WAnFbvsKbRLFI/b8qzn5fVjQOrxTnYsJy7gt7PG3EYcD6vGNYs3Au2aA9On/jRn1h0b5kK
 bnuQnl0bBsvCRkJG0gwDfuqHG6QAnTcBOe9AuvdKPf21vHgfpBxgalKxCYOudGs9tKIiNGCnl34
 8RWVL5KzGq1rNUmmV+2TlIA6f5oawPvDEZoiUiRvF6IvoiQ15FZIbihmkw8Jm7Y+Nri/TtTxJ42
 TO1lCrZCSXrUy6Ts2jOl4jda3dg/hyUpzzHvCckDJANgb4tvu88HduRfwZMHIPfC6gkB0cvdWCV
 IITy2GenM8pJJ0Z3YhDY7andps+BbCKaDU5tst7MKzqovmD5U
X-Received: by 2002:a17:90b:5112:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3903c592115mr12671472a91.9.1785990457360; 
 Wed, 05 Aug 2026 21:27:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3903c592115mr12671439a91.9.1785990456890; 
 Wed, 05 Aug 2026 21:27:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 08/18] hw/hexagon: extract get_reg_value/set_reg_value
 stubs in globalreg
Date: Wed,  5 Aug 2026 21:27:13 -0700
Message-Id: <20260806042723.3785369-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Z7oWjMIChS101MvDp-dLKu7_kvZTuIja
X-Proofpoint-ORIG-GUID: Z7oWjMIChS101MvDp-dLKu7_kvZTuIja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX1LjNhX9bLqqu
 wMao6MGxwOfGxkvFTyLHyljg9GNUliG1RM/zkOA71x7cV2oOe3DkzUrS2fOCXHPLfDZLz1YDFL2
 XX5ZynJldyFcuZpwGMu+Ush8x+6UHBB9W4PU43t/YORkEEqduu4usAvAq95uT3BvBTbGAKwIKc3
 J/8NMQlKP61Dl62dCxxN3FXKPTWJN9LLsKDMX1QoAHIDsHwxWth22x4qA7l3CgZ8v4bM5bGKTnS
 Nrr1TUu3I/cvVEue3OWnAUiI+ai18PdBxxVEYsq1fr6tCo0MaFlTtiVkv9V6dPbXiKVyrrDB29U
 MxrNRVcxYaexLLIFM8SPTX53oeeQK+mg4LUhI1AWs4nx5PH0467DCYG2kIM5Mim3mjUW4EuStnN
 /D15VCmkcZLYPOQ9NSf/yEzF+AtsFkZwpsdBxblPU0NBNmFVcs4tvxmF5jbhIlXSnCE58vSnp/z
 gPcDz3Tu3aX+rKmAVIQ==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a740d3a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Z4HElfRGeH4uGo3IGfcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfXx+StWLPNuUPN
 vWix/An5QNQiHFTufZcA8kFxttvwaj6+vYAqrJ2y+sxfYb1epVzu+KaHfWZ5P/gB8xP8XhG6A0b
 yVYnhRz1bHjRzbiVFS+TJn5Psre5rZM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

Um91dGUgdGhlIGdsb2JhbHJlZyByZWFkL3dyaXRlIGFjY2Vzc29ycyB0aHJvdWdoIG5ldwpnZXRf
cmVnX3ZhbHVlKCkvc2V0X3JlZ192YWx1ZSgpIGhlbHBlcnMgaW5zdGVhZCBvZiB0b3VjaGluZwpz
LT5yZWdzW3JlZ10gZGlyZWN0bHkuCgpUaGlzIHdpbGwgYmUgZXhwbG9pdGVkIGJ5IGEgc3Vic2Vx
dWVudCBwYXRjaCB0aGF0IHJlZGlyZWN0cyBWSUQvVklEMQphY2Nlc3NlcyB0byB0aGUgTDJWSUMu
CgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jIHwgMjMgKysrKysrKysr
KysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyBiL2h3
L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYwppbmRleCBiNWU1OTEzNTA3ZS4uMTA1NDc1MjE5
YWIgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYworKysgYi9ody9o
ZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKQEAgLTEzNSw2ICsxMzUsMTcgQEAgc3RhdGljIGlu
bGluZSB1aW50MzJfdCBhcHBseV93cml0ZV9tYXNrKHVpbnQzMl90IG5ld192YWwsIHVpbnQzMl90
IGN1cl92YWwsCiAgICAgcmV0dXJuIG5ld192YWw7CiB9CiAKK3N0YXRpYyB1aW50MzJfdCBnZXRf
cmVnX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnKQoreworICAg
IHJldHVybiBzLT5yZWdzW3JlZ107Cit9CisKK3N0YXRpYyB2b2lkIHNldF9yZWdfdmFsdWUoSGV4
YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IHZhbHVlKQoreworICAgIHMtPnJlZ3NbcmVnXSA9IHZhbHVlOworfQor
CiB1aW50MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAq
cywgdWludDMyX3QgcmVnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJf
dCBodGlkKQogewpAQCAtMTQ2LDcgKzE1Nyw3IEBAIHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVn
X3JlYWQoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAgICAgZ19hc3Nl
cnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NU
QVJUKTsKIAotICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOworICAgIHZhbHVlID0gZ2V0X3JlZ192
YWx1ZShzLCByZWcpOwogCiAgICAgdHJhY2VfaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBn
ZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKICAgICByZXR1cm4gdmFsdWU7CkBAIC0xNjAsNyAr
MTcxLDcgQEAgdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZShIZXhhZ29uR2xvYmFsUmVnU3Rh
dGUgKnMsIHVpbnQzMl90IHJlZywKICAgICB9CiAgICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdT
KTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsKLSAgICBzLT5yZWdz
W3JlZ10gPSB2YWx1ZTsKKyAgICBzZXRfcmVnX3ZhbHVlKHMsIHJlZywgdmFsdWUpOwogICAgIHRy
YWNlX2hleGFnb25fZ2xvYmFscmVnX3dyaXRlKGh0aWQsIGdldF9zcmVnX25hbWUocmVnKSwgdmFs
dWUpOwogfQogCkBAIC0xNjgsNiArMTc5LDcgQEAgdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdf
bWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZhbHVlKQogewog
ICAgIHVpbnQzMl90IHJlZ19tYXNrOworICAgIHVpbnQzMl90IGN1cl92YWw7CiAKICAgICBpZiAo
IXMpIHsKICAgICAgICAgcmV0dXJuIHZhbHVlOwpAQCAtMTc1LDkgKzE4NywxMCBAQCB1aW50MzJf
dCBoZXhhZ29uX2dsb2JhbHJlZ19tYXNrZWRfdmFsdWUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpz
LCB1aW50MzJfdCByZWcsCiAgICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fz
c2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsKICAgICByZWdfbWFzayA9IGdsb2JhbF9z
cmVnX2ltbXV0X21hc2tzW3JlZ107CisgICAgY3VyX3ZhbCA9IGdldF9yZWdfdmFsdWUocywgcmVn
KTsKICAgICByZXR1cm4gcmVnX21hc2sgPT0gSU1NVVRBQkxFID8KLSAgICAgICAgICAgIHMtPnJl
Z3NbcmVnXSA6Ci0gICAgICAgICAgICBhcHBseV93cml0ZV9tYXNrKHZhbHVlLCBzLT5yZWdzW3Jl
Z10sIHJlZ19tYXNrKTsKKyAgICAgICAgICAgIGN1cl92YWwgOgorICAgICAgICAgICAgYXBwbHlf
d3JpdGVfbWFzayh2YWx1ZSwgY3VyX3ZhbCwgcmVnX21hc2spOwogfQogCiB2b2lkIGhleGFnb25f
Z2xvYmFscmVnX3dyaXRlX21hc2tlZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90
IHJlZywKQEAgLTE4Niw3ICsxOTksNyBAQCB2b2lkIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlX21h
c2tlZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICBpZiAoIXMp
IHsKICAgICAgICAgcmV0dXJuOwogICAgIH0KLSAgICBzLT5yZWdzW3JlZ10gPSBoZXhhZ29uX2ds
b2JhbHJlZ19tYXNrZWRfdmFsdWUocywgcmVnLCB2YWx1ZSk7CisgICAgc2V0X3JlZ192YWx1ZShz
LCByZWcsIGhleGFnb25fZ2xvYmFscmVnX21hc2tlZF92YWx1ZShzLCByZWcsIHZhbHVlKSk7CiB9
CiAKIHVpbnQ2NF90IGhleGFnb25fZ2xvYmFscmVnX2dldF9wY3ljbGVfYmFzZShIZXhhZ29uR2xv
YmFsUmVnU3RhdGUgKnMpCi0tIAoyLjM0LjEKCg==

