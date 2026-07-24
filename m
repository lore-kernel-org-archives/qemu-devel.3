Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1B5C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm6-0002Ls-FW; Fri, 24 Jul 2026 14:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKld-0002Dc-Jh
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlb-0000vx-Lb
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqW9I3819246
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bCvN/D0ANbGnr8OjYvKUiIOXFnSi6v1pKikPQ/BUvxk=; b=l4kzhUD1puoAdkY+
 uJji6n0ve37aLS+SapEZvc7OF/XsGL3QMDVdYNCnyo0xCWLij4hbEhXt+gnl/FGc
 j8azmkfnmLHv5BeYo/5WuAQVGGD7iHfsn7xCl+Woi1eXnja2HnGySycXFdSL/L3c
 +RJ80oq8DmQW+/JiOmscA6XB0+YBSLV/jy5W8VLczg6t0wG/zEANXaPoOlr0Qh4k
 wEpfNzu94/YRqcpm+O0oXWXoWCCwQeOG31T4SnFyKqnVttVLggJM6n5Xez3SQ8+5
 6s3EOUDGo7wqyW7LF7lIfTm4km5EwW3mPcWwiwh9/C0rF7A68NBVJi00Kin8g5xk
 eMLbEQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm9pd0xag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so784391a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918222; x=1785523022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bCvN/D0ANbGnr8OjYvKUiIOXFnSi6v1pKikPQ/BUvxk=;
 b=Idv5dYqqtpphEV/+wbsR2AlQDqiaDQ6W3MTPnP0wu2q+ZhERvV6lkrZl73yNhqB/hH
 TThrGnw3PaXGoJez1+9z8e8Kvy1He65tDkuolwFxjscbRRPNaAhc38J4e0jxMlqUkn/x
 IXy43sTgvVtqkS8ckv1E+6Xg3JUuw+iZSRkPbNo9KK4nqgAFM3U/9PT3bvM60Th8kkX6
 DTU/QqoiKsWxWRcI7aqZCVIDSzTJ6ADmXc11DBa7naJ47m20DLya+34pN2EAg9Cu/mqP
 nPz4hyUwbQjVbd/9rs0+etCPaP2u0JVekJuFtYbIWQBno1RDRghRWN9pZBhvVGYceL2M
 ZcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918222; x=1785523022;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bCvN/D0ANbGnr8OjYvKUiIOXFnSi6v1pKikPQ/BUvxk=;
 b=Gaq402lxtXyg7M2IWNq7O+78Vboy73BAFkmlPe10pAvFciq1pCgFhkcBc6ud10x5t6
 Sg0Ot7WZzedY0Y/1XmM49yRU1ygrKZPHWTKgspXapwpCyRTCRNJMq8kg0cj7Mk61PJNQ
 t18hHfQf1m6IWKCpjh5kLjgy4B3PSaoAlFOafc8SiTzdgw81HcXH5AczMjvWWuGuQGKA
 P3HYbjqWbkqB7E8R2AEnM0rLXvttKA/E1HcjXjJMZ6k5r98l1e10VfOPsFsZGOyRfz/F
 XQT2d7rSo552rzQa1qwnjW1PVxAc2vyhEnLHL94sLcA9jpjGymE5/NWf2yJ9+FS2A+sf
 Rxvw==
X-Gm-Message-State: AOJu0YzYudX5bTs/Q55C49rLyZH4th5xICTiUgh89gphzYbYYrEUxh16
 QCE4Y7JfZnvmthj7Q70we4TcYpsyuu1CCOF8gtbo590s9yEusoaciCl0ksibb3JSBo7DpG5Bh+g
 Z+tFweuJgmH/wDUaNvgXCH+5J24vvKA7ARws711x5PWT1khFWcCdYP3ceXCicD+TOwQ==
X-Gm-Gg: AR+sD13nGPQ25ip2IcmmFnpPOwpTs6X5uYHq9ZQ8sqomDhfoArwQo4bABEXtarOChy3
 fM4L35Srau0UyFjYwui2sM3e9byl8wrKB6tD+N+PZYSFcuksf/H8Qu1cBIx8X8BuYEulvLXVbjr
 0qbFCtrZabKEBJWzAD8+zyeJbuIsIv/ND74v1Vs4Lc1PdIO2HUqmD6ruX1BY9kQJlwcIWQJvWc3
 GV18e+wQoUCjeZl6/qnAQWccz9jPmvf7QjkrtKA7H93j/MJI13JL3MBSZps90O984WvK/tLeov5
 PBsblLrFt8C/E0qt1DdkuYbYzZxdvN55L82YnWSxXVPZxyjzsbeml9Mci0RuVLCzh2HpdO4zEK0
 rhqUNjEFOeAgj4OPLpcQvJssegkY0UQY3bwtQga/C0c793gvo
X-Received: by 2002:a17:90b:2647:b0:380:105f:8ffd with SMTP id
 98e67ed59e1d1-38ec642bd77mr8428973a91.16.1784918221782; 
 Fri, 24 Jul 2026 11:37:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2647:b0:380:105f:8ffd with SMTP id
 98e67ed59e1d1-38ec642bd77mr8428953a91.16.1784918221364; 
 Fri, 24 Jul 2026 11:37:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:37:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 08/14] hw/hexagon/virt: connect pl011 UART interrupt
Date: Fri, 24 Jul 2026 11:36:42 -0700
Message-Id: <20260724183648.190531-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: WUCkfvmraDkUDyoGnnN_frMneE2s3b0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfXx99Vn+aU4jCL
 2wHkjnepZV/n+YcQnwR0GJAnj/8/nxon97+gUpyXm3dIOdTbv3YvQJeaE5rMjJgVoRTAUS3ivvy
 cLpGLBtIpCcIPcMD25f/6Gc6xUBFahd9mEUMJmj1TqvTWV6/VkD28mjF917jJqOa53wuoJED7Y5
 EVl+jMYpgzYGDq3VUd5vKFEIKXAMvAa8jL2kkdvH/4tGAiOaLt8D72t5MTyXHEwHUaMI7gQTDA2
 8oDl1UPavbVD28mKJ+vCQoh5IOK+hB7CtMGMD7xVVpSRmcoisQHeWoPJhoD4PV79QrtLyyvnIt9
 yiTlZ/bn3HxoSfrg+s1hys/r9AN3N36hDPVElMSTnKXBLKsucFw/9kWkn8LBZTRhlSAw3wJybQy
 SsvV8QQNA1uKkK4NHxMQwU1PTz2qgkJOXxuYxMPmdz8dx3ZL2cvh/0qBfHLiIXlFXIpDMOgeDDq
 zd3XvmBFP8/2hPhwNLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX9GeY2UxtU/lY
 NIE94Z8GcNoLK5d9uEjot0zEnqN4/VLIZ7+6Q7KyOk9zn/Lbqq6obH1YKmCAtGh+U39bbaAFRKI
 okKniKdvyR+60GgUw9DoN9jhT3esD70=
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a63b0ce cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=uX9m3dGBAM87qA7I_4YA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: WUCkfvmraDkUDyoGnnN_frMneE2s3b0C
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

V2lyZSBwbDAxMSdzIHN5c2J1cyBJUlEgaW50byBsMnZpYyBhdCBJUlEgMTUuCgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaHcvaGV4
YWdvbi92aXJ0LmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcv
aGV4YWdvbi92aXJ0LmMKaW5kZXggNzhlNzFkM2JkNjUuLmNjMzg5M2I4ZWJiIDEwMDY0NAotLS0g
YS9ody9oZXhhZ29uL3ZpcnQuYworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtNDAsNiArNDAs
NyBAQCBzdGF0aWMgY29uc3QgaW50IFZJUlRJT19ERVZfQ09VTlQgPSA4OwogICogVklSVElPX0lS
UV9CQVNFICsgVklSVElPX0RFVl9DT1VOVCAtIDEKICAqLwogc3RhdGljIGNvbnN0IGludCBWSVJU
SU9fSVJRX0JBU0UgPSAxNjsKK3N0YXRpYyBjb25zdCBpbnQgVklSVF9VQVJUMF9JUlEgPSAxNTsK
IAogc3RhdGljIGNvbnN0IE1lbU1hcEVudHJ5IGJhc2VfbWVtbWFwW10gPSB7CiAgICAgW1ZJUlRf
VUFSVDBdID0geyAweDEwMDAwMDAwLCAweDAwMDAwMjAwIH0sCkBAIC0xNDQsNyArMTQ1LDcgQEAg
c3RhdGljIGludDMyX3QgZmR0X2FkZF9jbG9ja3MoY29uc3QgSGV4YWdvblZpcnRNYWNoaW5lU3Rh
dGUgKnZtcykKIH0KIAogc3RhdGljIHZvaWQgZmR0X2FkZF91YXJ0KGNvbnN0IEhleGFnb25WaXJ0
TWFjaGluZVN0YXRlICp2bXMsIGludCB1YXJ0LAotICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dDMyX3QgY2xrX3BoYW5kbGUpCisgICAgICAgICAgICAgICAgICAgICAgICAgaW50MzJfdCBjbGtf
cGhhbmRsZSwgaW50MzJfdCBsMnZpY19waGFuZGxlKQogewogICAgIGNoYXIgKm5vZGVuYW1lOwog
ICAgIGh3YWRkciBiYXNlID0gYmFzZV9tZW1tYXBbdWFydF0uYmFzZTsKQEAgLTE2Miw2ICsxNjMs
OCBAQCBzdGF0aWMgdm9pZCBmZHRfYWRkX3VhcnQoY29uc3QgSGV4YWdvblZpcnRNYWNoaW5lU3Rh
dGUgKnZtcywgaW50IHVhcnQsCiAgICAgcWRldl9jb25uZWN0X2Nsb2NrX2luKGRldiwgImNsayIs
IHZtcy0+YXBiX2Nsayk7CiAgICAgc3lzYnVzX3JlYWxpemVfYW5kX3VucmVmKHMsICZlcnJvcl9m
YXRhbCk7CiAgICAgc3lzYnVzX21taW9fbWFwKHMsIDAsIGJhc2UpOworICAgIHN5c2J1c19jb25u
ZWN0X2lycShzLCAwLAorICAgICAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2luKHZt
cy0+cGFyZW50X29iai5sMnZpYywgVklSVF9VQVJUMF9JUlEpKTsKIAogICAgIG5vZGVuYW1lID0g
Z19zdHJkdXBfcHJpbnRmKCIvcGwwMTFAJSIgUFJJeDY0LCBiYXNlKTsKICAgICBxZW11X2ZkdF9h
ZGRfc3Vibm9kZShtcy0+ZmR0LCBub2RlbmFtZSk7CkBAIC0xNjksNiArMTcyLDkgQEAgc3RhdGlj
IHZvaWQgZmR0X2FkZF91YXJ0KGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsIGlu
dCB1YXJ0LAogICAgIC8qIE5vdGUgdGhhdCB3ZSBjYW4ndCB1c2Ugc2V0cHJvcF9zdHJpbmcgYmVj
YXVzZSBvZiB0aGUgZW1iZWRkZWQgTlVMICovCiAgICAgcWVtdV9mZHRfc2V0cHJvcChtcy0+ZmR0
LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLCBjb21wYXQsIHNpemVvZihjb21wYXQpKTsKICAgICBx
ZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwgYmFzZSwg
c2l6ZSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50
ZXJydXB0cyIsIFZJUlRfVUFSVDBfSVJRKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMt
PmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtcGFyZW50IiwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgbDJ2aWNfcGhhbmRsZSk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+ZmR0
LCBub2RlbmFtZSwgImNsb2NrcyIsIGNsa19waGFuZGxlLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY2xrX3BoYW5kbGUpOwogICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9kZW5h
bWUsICJjbG9jay1uYW1lcyIsIGNsb2NrbmFtZXMsCkBAIC0zNDEsNyArMzQ3LDcgQEAgc3RhdGlj
IHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAKICAgICBmZHRfYWRkX2NwdV9ub2Rl
cyh2bXMpOwogICAgIGNsa19waGFuZGxlID0gZmR0X2FkZF9jbG9ja3Modm1zKTsKLSAgICBmZHRf
YWRkX3VhcnQodm1zLCBWSVJUX1VBUlQwLCBjbGtfcGhhbmRsZSk7CisgICAgZmR0X2FkZF91YXJ0
KHZtcywgVklSVF9VQVJUMCwgY2xrX3BoYW5kbGUsIGwydmljX3BoYW5kbGUpOwogCiAgICAgaGV4
YWdvbl9sb2FkX2ZkdCh2bXMpOwogfQotLSAKMi4zNC4xCgo=

