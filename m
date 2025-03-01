Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7EAC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPF-0007op-Dk; Sat, 01 Mar 2025 00:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPE-0007n7-A8
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPB-0008Lq-6U
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:55 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Ggjv005277
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=YDErKpXDvet
 jAhr9s8VSfefEczjQla9A+sd2lBi9zfY=; b=GpxhrMOpx0qz6rTH3mWdo87P95U
 eeQ9GVuBQy3/dguKRQJ9Dp0WNwGYMtoveL6uT+S7ZxI6s6llqxIbM/cLHhd2rK0Z
 Dje8d3e/JLzZEOoVMYs5VAsXSQkeHtTu5L9WCiUbI3rcEvEiNBRGC8XH8Mmz/oz9
 eYSApWXxJ0G8hFKRDpuq7kZ3qnBqq8BrnB0X6m/Iokg3epdc7dsf9dLI7HNEKw02
 ewMBybFnhCDoww1QqGTGdcMg1UK64J37XKfG7PJtDHJIEGO9zVkuXPC1CS/SLITI
 Nk3TjsaK24KkzCkOtR/cRTKiGQlxyDStYyVYXa/nkF/pzQbhi5qr/4g/cYQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:28:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fe916ba298so5762767a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806930; x=1741411730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YDErKpXDvetjAhr9s8VSfefEczjQla9A+sd2lBi9zfY=;
 b=HrnRIt15orMxub5+FckzSoNg5x9KX5DH8E5nNFIrdqIhZQWsJ7jHHFKjXciPH8WyFr
 9kb9SOtdNmKVOb9sjNW62X93nJNicrbZtjrbqUYcfTEsYjyRA1+Rsm47nXvgmD7t/ft8
 q1l84atC7Kv5UPOoOuOHha8+KjohZXlavUA7CgQsVoTupqV98+YfKoC0SGieuHIADsg4
 fphoLI1p63hIGybkeFzT3ynmlv/S7/R3YLzOu+jNx56MGtdHtDO1fUHLd468op6K5pt9
 3ZhCMClcmDpxttdfk40ek2MEm3A5aOduu2mt4MXO+gSd4lhzvITd7GCVeFJ7niaoRxOG
 NtPQ==
X-Gm-Message-State: AOJu0Yyl11dsH5888xugs/j9X04SVvgcNwoPgplKDdq9jHjWxdZlZZRk
 5BjRwMef1e1hDLytYrfTCTL52k25+plQsDxQPrv6b1l3VWWzuiQd2kSvRKfbQABdHfDG7ddARSV
 otJvp4yjIl5X7GeP+YBucyt3mGljL3jaJX+4Oac9776hQUCCgJe2/mpz8ewFFDg==
X-Gm-Gg: ASbGncuhn2VUGQjt6ypN5gTSk4oOU41NeXE9b7m2DkVIXQRbfML/lNL8ew6ohBXRyz0
 XIDBx7qjg8vbmOlyqDvcH5woz0Je675YFL8IPr9/0aVgBkh1+pYYbFdGWDaPBrEY5iE0XmUq0Iw
 6yNHZvI0vMOL0O5wBv67ZaITNSZWJdEsOh7lESoUxUgGHtgnKhEDFKrglD7bKdD7IE6Zjxh2iOO
 GmkAjWG4mvhGhyyntajUcqdC9/C65agZoVZ8KD5rQeJMh6zxPrdWeCGE/JLUCLSvRgdHEgTgkXQ
 wubSt2rzAcy+UpOagT/xuddNenbkb8VMl6263LeeeEpjrH4xi3kIKK3PwOv33Mv/
X-Received: by 2002:a17:90b:2786:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-2febab2f911mr9431155a91.5.1740806930599; 
 Fri, 28 Feb 2025 21:28:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoCmrj9roWJamcNnwwiY8Oo+Rzx57dXtPPS/60KfA1ZOt/9DdvN1dv6Q1e9xaZ3sbDOel0dA==
X-Received: by 2002:a17:90b:2786:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-2febab2f911mr9431124a91.5.1740806930254; 
 Fri, 28 Feb 2025 21:28:50 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:49 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH 00/39] hexagon system emu, part 2/3
Date: Fri, 28 Feb 2025 21:28:06 -0800
Message-Id: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: VfsebIj21_XwYZGu3BPM6JvuRXU73xdh
X-Proofpoint-ORIG-GUID: VfsebIj21_XwYZGu3BPM6JvuRXU73xdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=327 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

aGV4YWdvbiBhcmNoaXRlY3R1cmUgc3lzdGVtIGVtdWxhdGlvbjogcGFydCAyLzMKClRoaXMgc2Vy
aWVzIGluY2x1ZGVzIHRoZSBrMCBhbmQgVExCIGxvY2tpbmcgaW1wbGVtZW50YXRpb24uICBUaGlz
IHdhcyBicmllZmx5CmRpc2N1c3NlZCBvbi1saXN0IGF0IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9y
Zy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI0LTAxL21zZzA0ODAxLmh0bWwKYW5kIHBlcmhh
cHMgd2UgY2FuIGNvbnRpbnVlL2ZvbGxvdy11cCBkaXNjdXNzaW9uIG9uIHRoZSByZWxldmFudCBw
YXRjaChlcykKaW4gdGhpcyBzZXJpZXMuCgpCcmlhbiBDYWluICgzOCk6CiAgdGFyZ2V0L2hleGFn
b246IEltcGxlbWVudCBjaWFkIGhlbHBlcgogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQge2Ms
fXN3aSBoZWxwZXJzCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBpYXNzaWdue3Isd30gaGVs
cGVycwogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc3RhcnQvc3RvcCBoZWxwZXJzCiAgdGFy
Z2V0L2hleGFnb246IEltcGxlbWVudCBtb2RpZnkgU1NSCiAgdGFyZ2V0L2hleGFnb246IEltcGxl
bWVudCB7ZyxzfWV0aW1hc2sgaGVscGVycwogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgd2Fp
dCBoZWxwZXIKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGdldF9leGVfbW9kZSgpCiAgdGFy
Z2V0L2hleGFnb246IEltcGxlbWVudCBhcmNoX2dldF9zeXN0ZW1fcmVnKCkKICB0YXJnZXQvaGV4
YWdvbjogSW1wbGVtZW50IGFyY2hfe3MsZ31ldF97dGhyZWFkLHN5c3RlbX1fcmVnKCkKICB0YXJn
ZXQvaGV4YWdvbjogQWRkIHJlcHJlc2VudGF0aW9uIHRvIGNvdW50IGN5Y2xlcwogIHRhcmdldC9o
ZXhhZ29uOiBBZGQgaW1wbGVtZW50YXRpb24gb2YgY3ljbGUgY291bnRlcnMKICB0YXJnZXQvaGV4
YWdvbjogSW1wbGVtZW50IG1vZGlmeV9zeXNjZmcoKQogIHRhcmdldC9oZXhhZ29uOiBBZGQgc3lz
dGVtIGV2ZW50LCBjYXVzZSBjb2RlcwogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgaGV4X3Rs
Yl9lbnRyeV9nZXRfcGVybSgpCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBoZXhfdGxiX2xv
b2t1cF9ieV9hc2lkKCkKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHNvZnR3YXJlIGludGVy
cnVwdAogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgZXhlY19pbnRlcnJ1cHQsIHNldF9pcnEK
ICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGhleGFnb25fdGxiX2ZpbGwoKQogIHRhcmdldC9o
ZXhhZ29uOiBJbXBsZW1lbnQgc2lhZCBpbnN0CiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBo
ZXhhZ29uX3Jlc3VtZV90aHJlYWRzKCkKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHNldHBy
aW8sIHJlc2NoZWQKICB0YXJnZXQvaGV4YWdvbjogQWRkIHN5c2VtdV9vcHMsIGNwdV9nZXRfcGh5
c19wYWdlX2RlYnVnKCkKICB0YXJnZXQvaGV4YWdvbjogQWRkIGV4ZWMtc3RhcnQtYWRkciBwcm9w
CiAgdGFyZ2V0L2hleGFnb246IEFkZCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoKQogIHRhcmdldC9o
ZXhhZ29uOiBEZWNvZGUgdHJhcDEsIHJ0ZSBhcyBDT0YKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVt
ZW50IGhleGFnb25fZmluZF9sYXN0X2lycSgpCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBt
b2RpZnlfc3NyLCByZXNjaGVkLCBwZW5kaW5nX2ludGVycnVwdAogIHRhcmdldC9oZXhhZ29uOiBB
ZGQgcGt0X2VuZHNfdGIgdG8gdHJhbnNsYXRpb24KICB0YXJnZXQvaGV4YWdvbjogQWRkIG5leHRf
UEMsIHtzLGd9cmVnIHdyaXRlcwogIHRhcmdldC9oZXhhZ29uOiBBZGQgaW1wbGljaXQgc3lzcmVn
IHdyaXRlcwogIHRhcmdldC9oZXhhZ29uOiBEZWZpbmUgc3lzdGVtLCBndWVzdCByZWcgbmFtZXMK
ICB0YXJnZXQvaGV4YWdvbjogaW5pdGlhbGl6ZSBzeXMvZ3Vlc3QgcmVnIFRDR3ZzCiAgdGFyZ2V0
L2hleGFnb246IEFkZCBUTEIsIGswIHt1bix9bG9jawogIHRhcmdldC9oZXhhZ29uOiBEZWZpbmUg
Z2VuX3ByZWNpc2VfZXhjZXB0aW9uKCkKICB0YXJnZXQvaGV4YWdvbjogQWRkIFRDRyBvdmVycmlk
ZXMgZm9yIHRyYW5zZmVyIGluc3RzCiAgdGFyZ2V0L2hleGFnb246IEFkZCBzdXBwb3J0IGZvciBs
b2Fkd19waHlzCiAgdGFyZ2V0L2hleGFnb246IEFkZCBwY3ljbGUgc2V0dGluZyBmdW5jdGlvbmFs
aXR5CgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyAoMSk6CiAgdGFyZ2V0L2hleGFnb246IEFk
ZCBndWVzdCByZWcgcmVhZGluZyBmdW5jdGlvbmFsaXR5CgogdGFyZ2V0L2hleGFnb24vY3B1Lmgg
ICAgICAgICAgICAgICAgICB8ICA1MSArKystCiB0YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oICAg
ICAgICAgICAgIHwgIDU2ICsrKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCAgICAgICAg
ICAgfCAgMTkgKy0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICAgICAgICAgICAgfCAgIDcg
LQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCAgICAgICAgICB8ICAyNSArKwogdGFyZ2V0
L2hleGFnb24vaGVscGVyLmggICAgICAgICAgICAgICB8ICAgNSArLQogdGFyZ2V0L2hleGFnb24v
aGV4c3dpLmggICAgICAgICAgICAgICB8ICAxNyArKwogdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwu
aCAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggICAgICAg
ICAgIHwgICA4ICstCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgIHwgICA1
ICsKIHRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jICAgfCAgMTEgKwogdGFyZ2V0
L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICB8IDMzNiArKysrKysrKysrKysrKysrKysr
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICAgICAgICB8IDM3NCArKysrKysrKysr
KysrKysrKysrKysrLQogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICB8ICAx
NCArCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgIHwgICA3ICstCiB0YXJn
ZXQvaGV4YWdvbi9oZXhfbW11LmMgICAgICAgICAgICAgIHwgIDgwICsrKystCiB0YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYyAgICAgICAgICAgICAgIHwgMjU4ICsrKysrKysrKysrKysrKysKIHRhcmdl
dC9oZXhhZ29uL21hY2hpbmUuYyAgICAgICAgICAgICAgfCAgMjUgKy0KIHRhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5jICAgICAgICAgICAgfCA0MjMgKysrKysrKysrKysrKysrKysrKysrKysrLS0K
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgfCAzMTUgKysrKysrKysrKysr
KysrKystLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICB8ICAgMyArCiB0
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmIHwgICAxICsKIHRhcmdldC9oZXhh
Z29uL2ltcG9ydGVkL2xkc3QuaWRlZiAgICAgfCAgIDMgKwogMjMgZmlsZXMgY2hhbmdlZCwgMTkz
OCBpbnNlcnRpb25zKCspLCAxMDcgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFy
Z2V0L2hleGFnb24vaGV4c3dpLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9o
ZXhzd2kuYwoKLS0gCjIuMzQuMQoK

