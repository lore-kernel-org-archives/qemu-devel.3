Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1143C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39X-0001e9-Rq; Sun, 28 Jun 2026 23:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39T-0001cr-Vy
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39S-0006FN-EC
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d0Nw1554573
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=Lq99E0ChaKramlS+
 R4QrRVWd3seTp0xb1iYbKDnx1veUAY+6tiyNG+mRVTZCU1E1i0ZW0eako/kzSVwH
 LuQo0aU49WF67Uq6istDB1VyFrjTX6ayAJygSLw+BZcH+lE+qJnd3gC2nEmGs9Xi
 7j6yA4+oJdB24XVM8lgKVMw2/c8R7ZmoZsmmowsQH9aV06mExg5sAWEq8m4gICQe
 GViDLSVB/jqrRD67co1ngOi0FrNzYNpEEFemaoxRcGb8q6iIuNOzF6lxnd6U1ScN
 BS5HKvgoVcnNyB+bk6X36KEg7aR9NXbY9+U1BsJZxbv6Bk+bx3B8PFj6cSPL4mmO
 bRmNpw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74e8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:07 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13980b6561dso7308764c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705546; x=1783310346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=hR151bkHEMJJTErHmX50BADuhiPhRphiC8ELIRlEPho4Gc8YUFHsqczbEDRpUWvNdz
 uDufzL6du/FT4ewBOJzBSGnEwKf660uV0EMVYTOX1CL2r+c/Eri2V5Wuk7RNvIa1H3d9
 +zzMameudnERUi+qgwpHPyp7SNFU3J3bjYtBS4BDAIBHW7dyvaZCL5LQD4LNcKPCs8Oq
 JtjH+kQh41/NiOjXYr7l8e0nkhUp6t3gr0m8LIVpJacWxAbjwS7SdVLSzLf7/PmqLP+J
 uBpm0dhWTFZeAmBo/4CMvIH3dgVK1DKOTDMTX3u3I7Hb72hznsRkzA2zE1hN5zKh1BDD
 uY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705546; x=1783310346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=QxKTSLolCNuXHTkKZM0TydeMWMwC0oBza0fWfko8fdeMqb0fYtZPZe3VBdcxyA2fRz
 LFwJ+MC1IoAeK0XZ8eErbh8+TIJu1DMm1BPllTZpCljl5XN19MHiHn6bVWmJmhlVt7nH
 qOdNKJNbsgWOQTSiRRo+k51NdpaRSPLcEz0VpNsaehaWjxoQu8b6+zm+e5guGbKecgzV
 uWSP2L6fP+JiIy2wCzWp/BXAWnTed3QO0ZK0rjcaNoUNWBQm1xSKUI40iZTJvQhqHyhq
 gd1Vt0/D5xesmgc8M0m1i78I7EziJCBblnG2Bl5rqE15Uqmjne7FHFhbktX3qmW4Qx7p
 7xkg==
X-Gm-Message-State: AOJu0Ywjor5j+fLgHTOVfn+1p2kYzuXqNeWL7jwNdEJy3c/ljc0myT5J
 q5HveO/VD8oIRj29Pi0GWNTgrjoPrXqLjEBjSjJ/FwdHlkSVLZRIW0hKv0PFgY7A6WaVuhhDfks
 k5q9313ifoue1T8aTwASw1Vj0PZQmyYT0O7OgEDgb+QwdZ8jVLozAlbYI8tTStoRudg==
X-Gm-Gg: AfdE7cl09vPQQDFqPJ4v02yYSyfMtUFBZc/X3QwKI2gn8PCf2lkRYIABdGw90aDFBY4
 W6Yhe/mdbt7tl7Z29Nh5DQyxcoDkADxourE7KApW+AClNwD8CTnYgB5Mf+eW+hnIppGaR5wVcep
 /OZOTAS+5MAh2HP8dF0E8WnGo/SOM8ddHWd8KkY+TXU4CqMkOfqXv+z2r4paN3i/DDA0IIp1c19
 HbMH9ird/rUQzOEC1/wLSxkzkcKOeU5zYcWVex7YIdEw4080u3UgbRDX3tz4wm1uUEqO5ipXUru
 6L1pFpYYrbfT8argM8+ayX0BEKPaYpbs6C/Ix8it04lkNjlX9Q9WFepJaeFwJk6uXW6O9CBgyq1
 Zf9hs1zhTBwyfePPWKjnH7+42VmjWxL+HvbxJQsXIJCy4QtkaEbhWhjFsA2M=
X-Received: by 2002:a05:7022:50e:b0:137:99bd:d156 with SMTP id
 a92af1059eb24-139db9ee306mr12028539c88.7.1782705546408; 
 Sun, 28 Jun 2026 20:59:06 -0700 (PDT)
X-Received: by 2002:a05:7022:50e:b0:137:99bd:d156 with SMTP id
 a92af1059eb24-139db9ee306mr12028532c88.7.1782705545897; 
 Sun, 28 Jun 2026 20:59:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 15/77] target/hexagon: Add guest, system reg number state
Date: Sun, 28 Jun 2026 20:57:28 -0700
Message-Id: <20260629035830.1520296-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXzlWj4gzinwbu
 sLHiaTu9V29gPp07qld9t3Z8AJDmt5XQo7yxJp48vFb3bBY1DJZZw54+iaFNzn2JY18ojKNRYBP
 EWGwEdDcVA5Y0Ys4NDWSLTid91KbkeY=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41ed8b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RD4P2OK31S7oojWqmcAsXrFy2fF_lv0h
X-Proofpoint-ORIG-GUID: RD4P2OK31S7oojWqmcAsXrFy2fF_lv0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX458QJ9YiAcz/
 Zdcdsr6DUvRPFljJVUGdDuSVeUPMrPOXrmUJp2yV8uozzOHH/hnOijwctPlHopUQuqIq9h5BEM+
 CVo2qmoGiQCueJ/Lzd/mLrm9tpugrEL0W9Xr7Hwjnhq51x22E6pMYLJjLCj9IKrpreyo7r9TCLS
 aTO0BEoP1DmR95y2qeJyKY5TwxPauVYJoPoNmE/DrSRiKlNZyacK1L0jYIZhznmOVDo6zJG1PCC
 zEBLjyMtWFg0y8fsqlZGLqrsmqX6N77iwEIN48tPnlJFD/OtW3ZGdwOXiLorRfbbVsD78u7eS5e
 GhBv3vuLK4pZqkDzRve+JTzjiBJt1kHEM6hFaku3hq8HAImGL868P5gfFWH6p/clLTmSWhWgkYZ
 jgi3wlNZl0OXF2GYmGPc+l0pHkENfQ0E0e3P/RrQyktp6+fFapLiGN0H7iRm/mvUZHEMfZ8bGjF
 RcP1FoUilXNP2XBXsAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

