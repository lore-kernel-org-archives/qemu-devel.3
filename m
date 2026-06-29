Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DCAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3dv-0003KV-R8; Mon, 29 Jun 2026 00:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3do-000346-Uq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dm-0001WA-1u
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NO3H1766946
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=; b=cn2g6HLHUH0YbOhC
 4Z1xOphuKRKbU8c2YcSFeXGk/lhbb05VR3rUd6aGRQmmSeHZV9ZRWbfa6M0r2SSI
 wyoPMmN8XEfo0N4/2savDgxYJY3J3uzTqW7I7aYYBtRcoytq/WUgem9Xxhp6IAlm
 QvL3lralZxsp6umrEC70K+RaVt1ruOfUbMtFkn3RKymgf/ZIaB27sBQgNN3L//Dp
 ki9X9T9OS6yZLZPiYBYZMmSRV6rU0LFJmCN8F3nJ7Fjl/gcInjksLyZiHOFaQWId
 YYk4MloDtWCUB77CnGCUIpngLODk93f58SYLLU06r/+7RYOJSP7aMGiCNDiayc6+
 kkICRw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a4g14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso2341878eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707425; x=1783312225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=el7hfBd0aJnmH3b6czpAbcRTp1cd0/59kiQU8D6ies/uwsRvQfqQxLv7ZEbxuhybcW
 VThImPwUruvz/yAjAj1T6lAiBYpOvTbQV7OQZRFvQJOP+KJSOo/CKFgG1Ubq/eKNWnJc
 /4mHoRhtFrPgkrODnzscKwTSb72eyWJTUL/AD3fkG1cTqSUejpOghbGAditK/lZW5wVv
 y6BfTja35i6daSC+U9m68y0ic+fJRjMIWTlecCasYLMZdKEGkkm5/hngUPWJKAuiwRcA
 qkQ8Q8M0P9TgG1C1ugQQj4yz9fSMuZgZMlqWGbBtytpF69LvVbBM897hCT+DppLbN+EK
 a37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707425; x=1783312225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=NOMjWxMVu+0zpVSnX2jKO+1JChyzmrLKvHJu5kWKIKI4EGIOOYBvl18Ea26vG9cabO
 +nlkgOlrfo2meFxqozok7MTmaaKIWq6/rc1xzNBbg3w2lxa3v7vk+GHPc35rVbE3y1ja
 fJIefcMucF4tiNE+tG/4Ddw6fMMX310hRDdImNVguSSHRUPyPuWNoVcSIkJTIVyojK+0
 dns/TvigAZVfAm0V2boii3UaDB49Jr5dCqU/W5h/V65NuQ3XML8FZtAnykIk9OMWHLGG
 qxVM2douqhnusjeVW3T9/ZHUQ9g9c99xD6sqfK3BxfuecCjojBDtLAjXHADsm3gjiJnV
 EgGg==
X-Gm-Message-State: AOJu0Yz1Y1hbMQ+0I0ikTYPHPJ3Cyl7HcilWyTDEQHzsgZ1LBITSUYEr
 k2dUn6caDpnyZgqCQmA81rnffHI4dRAxMqQy/u0SCdJt7aF5LJVERlBH+sNYV3yvWRR2el7SoQk
 /KrPLYuzL6Y4EajtkVav0kpnY9JUF0HWF/gE2ZuzTgN6xQhxakLF6aM2lOoytjePF5g==
X-Gm-Gg: AfdE7cl5/5yhetm+q8AA3BY129E0TuQUTiUn6wYjU9VcBPb+t+kLii2yWExQWUEiejV
 MvFJJneppelwTJ5TFlhzngNIZpr9Oohk8d2qe02V5GJfRX8SgLtwzr52vO7rvsaOf4rwEi9ZFSv
 jvSCXG/18rcEnUt1unSxf9SWCz81kTnyopA4L9sjomfAhtd3VDBFvmRfFU+dSt6nQxK8srk+K/Q
 gRkeavp4t68zGBzZFEsylK5DXCkqCzaC8Bk8zzBkyQDHgANQJ1HGOFWyNFiRnulpiz4UFsZNeRb
 3AYnMgcWvE9q9lI9la1YRGi/x+U47IAll0LzyRPZyRiu8wBVTg8voo8gyc4w9mkaOSTNgfqIvV5
 LAMUQjmMVMD61wnMcazO8oIdmVgGz705QqvdnAdAhRxOnIC6epfknnjlzSfg=
X-Received: by 2002:a05:7300:e8a9:b0:304:bce8:fa30 with SMTP id
 5a478bee46e88-30c84b2c0c8mr15278189eec.5.1782707424547; 
 Sun, 28 Jun 2026 21:30:24 -0700 (PDT)
X-Received: by 2002:a05:7300:e8a9:b0:304:bce8:fa30 with SMTP id
 5a478bee46e88-30c84b2c0c8mr15278170eec.5.1782707424065; 
 Sun, 28 Jun 2026 21:30:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 74/77] hw/hexagon: Add support for cfgbase
Date: Sun, 28 Jun 2026 20:58:27 -0700
Message-Id: <20260629035830.1520296-75-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+fPAHmgQcpAQ
 pUujq1UI9d1UUV4nmPc8zHtzllGHp7Irp8orxYAEivpUPA/lfkSMBiljsnfh4DA1XI6CylWFuWD
 TsFY/6UJDEPXLho4wMLwQFM/J3Jrs+9F2dKjh5d5em17si08sBOYnNbYl8QeoJ1sj1q1l0Rymn3
 g2hsRIUO+miW6NjSZbVtd9uqc+NFAZnROEJNLWL1tLTq1jdV4u2Hk865Fw1A3fZQ5w7NYM0TmY9
 L66doTM2Uc94hUkpNvILm420GBFuCxk8bN2fa1ZeHbWTQbOUHMjQl6GcwuaqcsrSnKnw3jUjanF
 DDEK/vsF+tOOSvNqBvFbCrIZhhJIZHaE4rk1Vy9fjOwzhSl/tyYvU13rl1QoUYPX011MiICQmGJ
 vCxLA1Yh9c2kRnURguGDx7Ug6g9AiKVQ7+Ndp8YcvPn+2CWErX8JbweKAlTGcnpsuPU9Z/CU8Y6
 Jk8ZPNpZqRUBtIZYFOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1UmV4DLcceGp
 kRzDuepo2Y2Yxd0vdMBCJI3jl3ifS84p0Gg4ju3e7Q9thUvpiwzxKUiCWfoX2UIGY3/lS8fys5u
 5VGXOtjGiv5+kN0z6WRbjKTIQcxfX80=
X-Proofpoint-GUID: rtJ9ekdlLaGyfNS1NM_7Fb93O0a3UAwv
X-Proofpoint-ORIG-GUID: rtJ9ekdlLaGyfNS1NM_7Fb93O0a3UAwv
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a41f4e1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNw
LmMgfCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDEgLQogMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ody9oZXhh
Z29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKaW5kZXggYWMwMWQz
NTk5MjguLmFhNDkzOTkzMjI5IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0xNjIsNiArMTYyLDEwIEBAIHN0YXRp
YyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCBy
ZXYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2RldiksICZl
cnJvcl9mYXRhbCk7CiAgICAgICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoREVWSUNFKGNwdSks
IE5VTEwsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorCisgICAgcm9tX2FkZF9ibG9iX2ZpeGVkX2Fz
KCJjb25maWdfdGFibGUucm9tIiwgJm1fY2ZnLT5jZmd0YWJsZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKG1fY2ZnLT5jZmd0YWJsZSksIG1fY2ZnLT5jZmdiYXNlLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwogfQogCiBzdGF0aWMg
dm9pZCBpbml0X21jKE1hY2hpbmVDbGFzcyAqbWMpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDA2YmU1YzhkNDk4Li40MmQ5M2U1
ZGE0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKQEAgLTQwMCw3ICs0MDAsNiBAQCB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiB9CiAjZW5kaWYKIAotCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKICAgICBDUFVT
dGF0ZSAqY3MgPSBDUFUob2JqKTsKLS0gCjIuMzQuMQoK

