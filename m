Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74975C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm0-0002JA-8o; Fri, 24 Jul 2026 14:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlZ-0002Cw-Nb
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlW-0000tm-9X
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqmZg3820281
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GxFyteMO3sTYlt4x+tO4uhy7i5ayUmWTd3DvO8rYV+I=; b=CJuaGJD//AD2irkM
 qq7mrovfj5U5keI+WZrrmnLDKoL9PpaXkN7Redpp4qBrkpw/h4IT+vtKdORz6Dj3
 doVYTtBqcpoisiGdCvsTZH+4Uqk+ZHWXvnWyll3/4bOZhfdV1PmqPH6i3iFC3wqC
 nf+ngJz5fLvij5cul4zkc0hvghSz3Z93IoWFPT+IU6vUYHE9W2cQmyvC71Ic6C/h
 t/e3alc8SoNel40iYh2B4u0gRKmVwfFUXyZ1/q0NuUzqELmqu/deog2X/Wl+BLpg
 tfn/X2dqY3+eoAiGQv5BGzyxhnQKXFI9+U4yKbUsSm3WKN3MRDelja+zgRYUy13Y
 ovOfoQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm9pd0xa0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:36:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso895059a91.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918216; x=1785523016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GxFyteMO3sTYlt4x+tO4uhy7i5ayUmWTd3DvO8rYV+I=;
 b=VLgQcch6X2Mo3KLc2dx7Vchx9Qokw16IIMf7UzRcs68OciXmAeck8cmUukYroNsgJQ
 6yc6CaDbOHVm/RWgWld1HNnPeBOM4xZoQj+FKBa7y7Ro6qhgP8aVqpk3rPgH8h9z/C+2
 MGAuqd7KpVVzFRRgegCGOg7ZYvjekKePapRQ+JKjwQAK3n6Ft1/zv0I36gIjUoW9vj8D
 ncSU+3GGBbrJcpwwBIPw/2MLNHQpQoNdf5Y0aMrnSaqgBswOXC5h0fkxXCZ05e7P3GWl
 LfbNaXK2iWUinewyhSai4swOmO0r2aOCHEYtpnxUiQpEbA5SPtwoB4D9dvmrq03rFrz3
 xebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918216; x=1785523016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GxFyteMO3sTYlt4x+tO4uhy7i5ayUmWTd3DvO8rYV+I=;
 b=ONpwPsiYHXFIepZmAlOb6mlohhwAToDf6h2WM5FMoCULROYD3yeGDqBA0n2YHG6Tfw
 Uo5hFf7jkkZmghSCs8t+YpwpreC6HKd35d7ykT7TtAcJUxnAqG6lcuNmU5RE9icsmSFj
 0hrjZ3WpJQr1ZMSE5RoxSdSbOpLlP8F9pnThaTarkV93oYlkx6uFNMwdRljeE+WGPVf1
 riLGRs/STfpsYXIoc4j2PwDF60oBJ9tNh2on9aqb+b2CBFp0uboDqfrhj8HABJ5nZy03
 MVbZcXXuIcgxPrXeHCampHY6Hd4ho6q+NDZdbQFQjM4S2V2g4q8K/AQ3+BAmoepU903o
 EP2w==
X-Gm-Message-State: AOJu0YyIUh2N6AJDKJJxz0hMCdXTf72EpsMwcOlu0pa7nSMjIHawIqza
 RtZh9fTxithA7Tky6t6p9UfVbJtubQUiO7Sub8VHn0zTzYMMSv5lm8OJ0N7bB1XTCYnGfWenqVe
 xGnqqVjRwGBVvjRhLEdqiUzGVwfZPQCb22TzM3sZ8H5Fm5GP+MJuy6ne+l3q54Dgsrw==
X-Gm-Gg: AR+sD12v7rDES8DolC/t1nLkoXTpfUtS8gl3mC3IWSm7VGhNe8JYemXsgQSbISs+2Te
 N5cSMrZA/vy0qW6eSXCF7xbcIsz4pZftOisr577sXAAof+jXqDhxgZRMoQOxbVJWQK04RPyCZNS
 ZZc+oOT3zvT+rO5y5UCBanHlQUp00v3Qqs2SzKGowz+bz6i5tGKRD8nHgWhBgzsiJtgyOnlwxeM
 ccSYTxOdfHMQk8blvg8TdUrWQHMWApvyfIwZJULA8B8EI9Z8CMTt1VOy6YKlZl8P5Mq+C7ycU/z
 OyZO0oe388/dPb4ULkMsri5qPOvZYJW0pLNstyg5mjPo8JyK+DqxXLcSHKAtSZerUJsfgZKXTSF
 yVdKltLT7JzUom5SgnU751+Y3u+BN2riwU3XM/pYnBzMLCWN0
X-Received: by 2002:a17:90b:33c1:b0:38e:76f8:fcb1 with SMTP id
 98e67ed59e1d1-38ec6a7a53amr8013108a91.32.1784918216197; 
 Fri, 24 Jul 2026 11:36:56 -0700 (PDT)
X-Received: by 2002:a17:90b:33c1:b0:38e:76f8:fcb1 with SMTP id
 98e67ed59e1d1-38ec6a7a53amr8013082a91.32.1784918215794; 
 Fri, 24 Jul 2026 11:36:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:36:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/14] hw/hexagon: extract get_reg_value/set_reg_value
 stubs in globalreg
Date: Fri, 24 Jul 2026 11:36:38 -0700
Message-Id: <20260724183648.190531-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UyAveN5gMv9WsVp6e2BHOAWzSHBnftvH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX2b2LRhBVD7Cq
 sRtPAEQSYidGuVEXbTQL9i+3iQmbXhtETe+T5puE4H5bNG0GID7lksS2PaIUgSiQkHGGZVTbW/t
 5XYt7UNkRdG6UuQzqpWADm7hnSvB42fQCFIF3x1K9CS/0IA7297PmmthxfScTxoJwATEH56zYwl
 PRIrHRcRt8jeEKtarX9PrAkQA4nkhJaJ8ul9AV/FV5yQgiE09SDfVoGi4LvDeqrvjfALHjh/le2
 9WetX81HfhjzuP5iAmDTXKtNSWI/h8BTw9SJ3W2E5C7qLrTXvo+yfJcHT7dLJpWDRdYia11KdiA
 L81sTG94VhGElu8/snR4ehqpF/SzUaQEaxCXOy2FP1t2FgU8WUbCdg5TZ0KMQESbot+AgNfVbau
 NrWYqS/aEnb94R9xji0n3m8f5hLDg5BOvPcjrwyNUJAzDBjmR0IuBMxqDpmKFxHHTLyAYMyfZTu
 sjS+ErZ28pSWaAJ8LOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX88XnwDiu1snp
 qKElrXgp1heOEvkdwlQ2LgbW0Bttu052NmgWWbmX1OfxT1AfpKMlie846RGlzuxnCuD2dG/MUZK
 nkOQINkEHHTx+FFymk+9f3OWELsC7u8=
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a63b0c9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JImm_8bkMh62Gcu6irQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: UyAveN5gMv9WsVp6e2BHOAWzSHBnftvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240167
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
CgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jIHwgMjMgKysrKysrKysrKysrKysr
KysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyBiL2h3L2hleGFn
b24vaGV4YWdvbl9nbG9iYWxyZWcuYwppbmRleCBiNWU1OTEzNTA3ZS4uMTA1NDc1MjE5YWIgMTAw
NjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYworKysgYi9ody9oZXhhZ29u
L2hleGFnb25fZ2xvYmFscmVnLmMKQEAgLTEzNSw2ICsxMzUsMTcgQEAgc3RhdGljIGlubGluZSB1
aW50MzJfdCBhcHBseV93cml0ZV9tYXNrKHVpbnQzMl90IG5ld192YWwsIHVpbnQzMl90IGN1cl92
YWwsCiAgICAgcmV0dXJuIG5ld192YWw7CiB9CiAKK3N0YXRpYyB1aW50MzJfdCBnZXRfcmVnX3Zh
bHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnKQoreworICAgIHJldHVy
biBzLT5yZWdzW3JlZ107Cit9CisKK3N0YXRpYyB2b2lkIHNldF9yZWdfdmFsdWUoSGV4YWdvbkds
b2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCisgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IHZhbHVlKQoreworICAgIHMtPnJlZ3NbcmVnXSA9IHZhbHVlOworfQorCiB1aW50
MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWlu
dDMyX3QgcmVnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBodGlk
KQogewpAQCAtMTQ2LDcgKzE1Nyw3IEBAIHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVnX3JlYWQo
SGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAgICAgZ19hc3NlcnQocmVn
IDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsK
IAotICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOworICAgIHZhbHVlID0gZ2V0X3JlZ192YWx1ZShz
LCByZWcpOwogCiAgICAgdHJhY2VfaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBnZXRfc3Jl
Z19uYW1lKHJlZyksIHZhbHVlKTsKICAgICByZXR1cm4gdmFsdWU7CkBAIC0xNjAsNyArMTcxLDcg
QEAgdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZShIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMs
IHVpbnQzMl90IHJlZywKICAgICB9CiAgICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAg
ICBnX2Fzc2VydChyZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsKLSAgICBzLT5yZWdzW3JlZ10g
PSB2YWx1ZTsKKyAgICBzZXRfcmVnX3ZhbHVlKHMsIHJlZywgdmFsdWUpOwogICAgIHRyYWNlX2hl
eGFnb25fZ2xvYmFscmVnX3dyaXRlKGh0aWQsIGdldF9zcmVnX25hbWUocmVnKSwgdmFsdWUpOwog
fQogCkBAIC0xNjgsNiArMTc5LDcgQEAgdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfbWFza2Vk
X3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZhbHVlKQogewogICAgIHVp
bnQzMl90IHJlZ19tYXNrOworICAgIHVpbnQzMl90IGN1cl92YWw7CiAKICAgICBpZiAoIXMpIHsK
ICAgICAgICAgcmV0dXJuIHZhbHVlOwpAQCAtMTc1LDkgKzE4NywxMCBAQCB1aW50MzJfdCBoZXhh
Z29uX2dsb2JhbHJlZ19tYXNrZWRfdmFsdWUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50
MzJfdCByZWcsCiAgICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChy
ZWcgPj0gSEVYX1NSRUdfR0xCX1NUQVJUKTsKICAgICByZWdfbWFzayA9IGdsb2JhbF9zcmVnX2lt
bXV0X21hc2tzW3JlZ107CisgICAgY3VyX3ZhbCA9IGdldF9yZWdfdmFsdWUocywgcmVnKTsKICAg
ICByZXR1cm4gcmVnX21hc2sgPT0gSU1NVVRBQkxFID8KLSAgICAgICAgICAgIHMtPnJlZ3NbcmVn
XSA6Ci0gICAgICAgICAgICBhcHBseV93cml0ZV9tYXNrKHZhbHVlLCBzLT5yZWdzW3JlZ10sIHJl
Z19tYXNrKTsKKyAgICAgICAgICAgIGN1cl92YWwgOgorICAgICAgICAgICAgYXBwbHlfd3JpdGVf
bWFzayh2YWx1ZSwgY3VyX3ZhbCwgcmVnX21hc2spOwogfQogCiB2b2lkIGhleGFnb25fZ2xvYmFs
cmVnX3dyaXRlX21hc2tlZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywK
QEAgLTE4Niw3ICsxOTksNyBAQCB2b2lkIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlX21hc2tlZChI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICBpZiAoIXMpIHsKICAg
ICAgICAgcmV0dXJuOwogICAgIH0KLSAgICBzLT5yZWdzW3JlZ10gPSBoZXhhZ29uX2dsb2JhbHJl
Z19tYXNrZWRfdmFsdWUocywgcmVnLCB2YWx1ZSk7CisgICAgc2V0X3JlZ192YWx1ZShzLCByZWcs
IGhleGFnb25fZ2xvYmFscmVnX21hc2tlZF92YWx1ZShzLCByZWcsIHZhbHVlKSk7CiB9CiAKIHVp
bnQ2NF90IGhleGFnb25fZ2xvYmFscmVnX2dldF9wY3ljbGVfYmFzZShIZXhhZ29uR2xvYmFsUmVn
U3RhdGUgKnMpCi0tIAoyLjM0LjEKCg==

