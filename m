Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1006C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm3-0002Kv-A0; Fri, 24 Jul 2026 14:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKli-0002EJ-Ah
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlg-0000xJ-1K
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqfoE3517532
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=; b=h3DQcVht1RGydEUJ
 9SW59P4hyfqSbl/uaFs0zGspp2+hDnN1tqE2pXEMatL6V1mkXFWCWtKG2wLN38hc
 PkBKZAzsOsL6n3HnGRAWT0xic7dcCMmR1PrEIgQNwEq4XWXmP2aEKSIEGmk8kQdn
 lGArDok9h9emGhvdToyL7XU4WvxTKh+4lWj2a7QTnMSXIjpRT56FzIsVD527ZhYg
 4moJrXAnwdsl6UQZp2XRjSK8qRABMcmYUN2n2fvviMoOLrGNY2kdHTPhchIMqHMt
 uevFwmr/jtbD/REvztLBJYV4eO6YU9yE5IPJH6v/m4cmhxeFk65W5CcSXsnVQWYK
 xlFB0w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pwb2t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so1485423a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918224; x=1785523024; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=;
 b=D4HEQ9HJzksSHGQzeT7UMC+eClAGhnt1H08ciHoitpjPtl8Q524LdkSTtTo8Yx5j8g
 3mcyUpenLVZrC2ecw4kZvCsae3HEOqcaobWL2rgK3xqxlfjqVN1B/1g8vDgMB65r1ZTY
 QIKBpOmOY8OfIKM+jdHBPH1M6qxLBif8opiyJydigGKqNFkjWBNzxSoMg9/NCcY3fOeq
 Z2j5jKRLVr240Yn/7RyGndJLUnyF0EDg9RtmyFvhBvNW55goVgk1SvbrpSP37JiXRfPc
 pOGKabhuNKJvE4Tb9aRGXUjbfgIyeI9al8ms+lyItc7e2pHRgdk2hes/kfwjY1qnFEUm
 MVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918224; x=1785523024;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlYwLmXhxTTRa9JsiNHuhC5FeaNc/fhNT3n5nZwsxj8=;
 b=nJQWMy9btwhJli8yhd7L7V9digHLbfq2/NRTJTXOakHB7Dj7Lgn6bGIVqdklGmru+c
 wpIfuUh1bVk2ndUFm+sfd7IFNsWR1zhtcYqOGI7oGGcDNTGrIjEAsBtWv1+eIZP0CcY+
 htkXOCvkHF1KNG3jmKe9CV+XMoUkjcAmaYxSYit8p9JtHbcgF8u3BRTkQajg+r8If07E
 bjRJIVY9b1osWFS8SiV7ycLybKi7ntJD0bgW7ly7LFONk1XtoKB/7NPqytEmeLH7tcFK
 DDUr/YDBxefhuDbanBzusgvy/vxQBHBW4Q4EiZ6/UymqpqZrviF8U+YBONO2udIMWu6L
 0xUQ==
X-Gm-Message-State: AOJu0Yz7nsKxhReAxa6rIt2omPbwucL38Do2Rm6XNeNGppZGymthheEr
 Pip8OITqkE0U4IGRchwNosDMTjKKcG+NFYIlqVcbGA7GvmOJOazHxbuxlGI2Dg5B5+xj7zAHSAv
 ZjWZlMCaLTgCu2LxyAkw44RHLC3FzEA9iszEmCWKPg0sM1Kbbi6pyDoAE/BYmLs9JyQ==
X-Gm-Gg: AR+sD11dHKWoJf0iwRd+YUC3owoVxIgBcwi19cwS7dFskech1LYBo7QgyPDKdih82C+
 S+rSRZa75qM6B1EUEkqA6oqpll5y3OdQXmtBDqGKgR9jJ62hN0MdA7C3ot5g/7xngIP3AYw7PeO
 oDMYvPa/zj/Ffq0crf4ylacPSSwhmA8k3fOkuWp8cKusDJu/h/oHz9KdlSyvlP6f/e+bCfA7TeA
 9vvguSvtCN0rgXY6Gq0yQEuPr7JSyxxSVClWrd72vIFMQdo0Xzqqub0hzdSUzkxynjL7naMXkiI
 Oq7iDfsXce9gtPZgFAIbNxLxlW+afrZnOMEprE9Ays/VHfzZ+UZ2toBjjjJbOmqAiHyHVBdjCxe
 hMw2XNPqtnZjQ+NC0k4AoDO1CxTZhpCA/ohVVPvLBKjFfd9pZ
X-Received: by 2002:a17:90b:2b88:b0:384:5b5b:3465 with SMTP id
 98e67ed59e1d1-38ec68771a6mr8772183a91.29.1784918224551; 
 Fri, 24 Jul 2026 11:37:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2b88:b0:384:5b5b:3465 with SMTP id
 98e67ed59e1d1-38ec68771a6mr8772146a91.29.1784918223876; 
 Fri, 24 Jul 2026 11:37:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:37:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 10/14] tests/functional/hexagon: add arch_tests functional
 test
Date: Fri, 24 Jul 2026 11:36:44 -0700
Message-Id: <20260724183648.190531-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX6Xwp3Tk92+lZ
 6oc1pugQoT+GwZ2C6btX4qYlaSaF2AZvj2otaEaOyPIfLoodF7qVa9bG03wWKlz6RcrPR7eFep+
 pcpO8UEHICGn9EOozzjwXvcp8xfVPyyutSVPX8ava9jJ3I1zEzQ5mRCxzsjCgdT70wo9hh/Wu3K
 pKoJMkQfzTN0aykJC1Eqk0xXYotNZENvteQIRskDFH3vTymivs2w/52zAYc/lVADhRs72c+oH0v
 Ho67zZkfF0xKO65YoYSHPoL26j4Gb3OcygkVGRAYQzvQTE8UzMQh6X9tBDv9MNvJ8d2IldyfhJo
 m0tPEUkzD1vtxzFSm+RyP2bYSdC4YNthvWnjtBuWTsRKn3j1AVRfUmhfccdVfWW5bau/HJi/q9W
 +eet/ZH3CkEkleuz3O3LRF2eRZOV9FV3/dwGRIvAfd4KBb5EB1ZYUcoMv4PF9P3peAPm6sNUq7F
 6VbnUfonEfiILfw+g7w==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a63b0d1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=X9gmHREV3qooIQp-wBoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: fjsYYjyKKJ3llctBYGcRtnJ_tRNaBHA9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfXzqWkXyZdh7bi
 +syF+2isvLg1BdZFC6p9s2EuxEDuNZtGpB00Opj3t2w9gQITrPnjoY5PfuLbUwae6VmvQhYRCLV
 1lMZ48ogSG89SXAW6BTuVn/67mos5Jw=
X-Proofpoint-GUID: fjsYYjyKKJ3llctBYGcRtnJ_tRNaBHA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
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

QWRkIHRoZSB0ZXN0X2ludF9zdGVlcmluZyBjYXNlIGZyb20gaGV4YWdvbi1hcmNoLXRlc3RzLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkg
fCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDU0YTE0MTJjNTk3Li4yYmIz
NGY5YjhkYyAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90
ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5
CkBAIC01Miw2ICs1MiwxMiBAQCBkZWYgdGVzdF9ndWVzdF9tb2RlKHNlbGYpIC0+IE5vbmU6CiAg
ICAgICAgICIiIgogICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfZ3Vlc3RfbW9kZSIp
CiAKKyAgICBkZWYgdGVzdF9pbnRfc3RlZXJpbmcoc2VsZikgLT4gTm9uZToKKyAgICAgICAgIiIi
VGVzdHMgaW50ZXJydXB0IHN0ZWVyaW5nIHZpYSBwcmlvcml0eS1iYXNlZCByb3V0aW5nIHRvCisg
ICAgICAgIHNwZWNpZmljIHRocmVhZHMgdXNpbmcgU1RJRCBwcmlvcml0eSBhbmQgaWFzc2lnbncu
CisgICAgICAgICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3RfaW50X3N0ZWVy
aW5nIikKKwogCiBpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0
Lm1haW4oKQotLSAKMi4zNC4xCgo=

