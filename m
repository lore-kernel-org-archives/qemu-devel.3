Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB377606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L2sfes4z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dv8nYIxk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhQ-0007rf-8I; Thu, 19 Nov 2026 22:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhN-0007qa-Oe
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:05 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhM-0000T4-0H
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:05 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3Us9q498094
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d0aoD98LkWQvaKvDVYrbpf8xKuW47G/B8oLzIooo5Do=; b=L2sfes4zZ++8yMBi
 pGvPLgbxLwW+enhFYr96DGYrzeaPtVHMtxLl281VDP7FZQ1KZfG9JZTyJp14wVVu
 qwL6kBIDArY5ca6NzlPei76e6AzWwnyC8SJjbNUpfyisABYhUVpW/bzGxnPtQKEz
 PttaT+KLCxhUf/RqhO1lzpLQNmYN/tpZ4im0dingPD34GTey9Mtg/uRIxhMdpOO1
 o5frzwVzwDLjqfs2L9dSPE3vIfv39SFQoRtkyav5SbG6Dvbpaw3bVWGx/+6618dq
 n9+qjV8bfx8yy/qrnXyNsEaHfTWkLqio+ee28wj05I4MMWJB5QYkIgsSwK9hbcvW
 WIheiQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255wjk2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-375bac6bd21so437508eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146841; x=1795751641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d0aoD98LkWQvaKvDVYrbpf8xKuW47G/B8oLzIooo5Do=;
 b=dv8nYIxkM0jkYaSp1b0S8p76QBl2XRoimUd4Ar3Ooltnf22YIVQtpzOJ/KLOP6se0E
 f6K6gjPPF7NxlHbN1i8ArAdOhz5hqI5oNCMmqNu6Jtg8pfFdic5a/wMTTwqJLh3K40aT
 e7qUp7lJxb0PmFhrzZvUmJh6evZAObW83IVI98bC5EZXZstQ0tDYEC0eORU2fORIluhA
 pxipDxrIvnzuoOYVcLaZXpkL3t8/V5wu6PTJWYXPSLFlUP8Whiv7ZZe/MiroN/5B26zt
 JrXyjWBSMumr/4xTWbs6Onrqeu9q8OBGEwc7+kPgpHvWDKni2i1QxakjCZz4t/sBmhJ7
 sIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146841; x=1795751641;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d0aoD98LkWQvaKvDVYrbpf8xKuW47G/B8oLzIooo5Do=;
 b=FzNrJeJ2Z/3BkIG7wRMKd3o3V4uS1wd/4ooXiD0Ka7eg0oxGfuaqWbQgucUVQuRzw7
 lZ/xpmXbB7qkNWkjK1x2s7ovZRoG3ha9oPL/ugDr+WPvNV7v+jDUCxKI9SumMwPtZ6yW
 ez2liXrXKBN0nJqGNytZKvWPbTauG+D/A/K5tlWVp5zpX6NJXv85WR32munJYVfizmHQ
 GfPV9X2LId9PpwyLc6h2K0RXBzzwLJ0R+RvREcQpAh8J0qs8oDme1kpBj5NN7Tk7bHrV
 NPiUT2ebGBgYuLXq/1I/qd4h7xMUvnTFgg6S0yyljfwQd2w2nrdJhBPfoTJLzEm+1kq5
 u7hQ==
X-Gm-Message-State: APuU4Z9CIQyWuemJKrGSMYjhgKKyOs0ypgvzcFb9fF2fBrBP3uKuZ4Eh
 4gKpGLwWfq1Mzc6Jx0igaz218BnnDG2xvUHfviZ0GjqL8CDbf5um7XGBPddsDvuhOnW1t1qe9gi
 wmjaa9k6lVxA5t9b5PQ9vD4M9O/gpJKP+/Yr/elBFuCmxGt3hj5ivkFloPBdaTu++aQ==
X-Gm-Gg: AZFdTZdcyrGvW7pJEVc5HRXQwdX9miUWAVnrWKG2msBFA5+/DhRfV5z5XuUxSMZmwqH
 HGSGM8q+bDhAFItAF2SGo9hOtwl3W6VqaSTviyTASQ26TL816z5YTJm2jfH+3MrgZ12VAGt972/
 fXkUy59erB0b4WnqG6wGZBA5hPvWjJeVxLnXdsMzUw6ssh0HmtrCY8Gx1gIQ5fKaiCxh+0CxnLJ
 GSrT6KXUFgXaxpln/jO20f5qd9nIq+WORNTET75rBlg6OzNwGy/puMZVCS2FIYFqei6679HGGts
 /UytbcmX8AeDkitStYkLvIb5I4lwJFCA8a3mXfGsvF0okYh47PtPZQE0dgFOm/xam0VTRFU7/XL
 oVjt5Jo9dteU7+Muy+IGDZKMToIGLcidCm5Zo4YlFQ2ochxK2ZOyiggn+GZuCeM4iCGxXE/rG/s
 mV2yvXjFW7A33Pc052MqRa
X-Received: by 2002:a05:7300:fb07:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-384b446d603mr2701416eec.18.1795146841438; 
 Thu, 19 Nov 2026 19:54:01 -0800 (PST)
X-Received: by 2002:a05:7300:fb07:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-384b446d603mr2701398eec.18.1795146840944; 
 Thu, 19 Nov 2026 19:54:00 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:53:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 2/8] target/hexagon: Fix disassembly of extended GP-relative
 accesses
Date: Thu, 19 Nov 2026 19:53:47 -0800
Message-Id: <20261120035353.3215703-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX2vFRRkbUxOCM
 VNOt0kdzbd1IOyc+Y0NXfcbxa2Jw1IuhpWnb3//UCMrOS1dA6z44oNSJhRM4060L+aXxOpnIWf/
 dplLz5Q6KdYQ9rNi+Mya1SdgAXLNEzk=
X-Proofpoint-GUID: DHfky04lFpKKVwz_sqTixC5FIN4d3Cp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX2O4mk8iZs01N
 YGoyg7dOioeTU6hXYutkH/F7jraHHz7iRzvphdDfrFTMudmmNO3nVxRph6Ss10isHK6FQHUzrEA
 0iPs0xGfK/Ei5+6hR3sZTddZLMVKtafqsiwO8nDouVUSN5MGaN7YEMXGko8NW8kUQ5Z31Y0FoOx
 Ls3+9g3L71WmrljtlUkZVeFmluKAPJm9SVj/sjNLaC0u1Pn3vlMpYpCErySaSDwq827xq6il9s0
 Lyep5q7PuHdb1nBM92D9h/pMCZJT9VAT0EJViAsOzoyOVJdG+KkQp1fob5T3Mp05I23koHQ27s3
 +mmNh57gi+0ee7ACbI2QBuoWe7D9yi8ponRSQLVM+YtI72sXenesQ0byraBsNdF+hocO2jU/fQT
 6rEoDB6Z/wuYaRavIrxS8iE+6zsUrutJukqxrao35No/dnCwL3ijd5CL9wKsnN4KAv92wP+mzzT
 9sNqC1LSYF/z5A8Diqw==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6affc45a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KjefK8gMg-PaKceYsj8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: DHfky04lFpKKVwz_sqTixC5FIN4d3Cp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200015
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QSBHUC1yZWxhdGl2ZSBsb2FkIG9yIHN0b3JlIHdpdGggYSBjb25zdGFudCBleHRlbmRlciBpcyBh
biBhYnNvbHV0ZQphY2Nlc3M6IHRoZSBzZW1hbnRpY3MgcmVhZCBHUCBhcyAwIHdoZW4gaW5zbi0+
ZXh0ZW5zaW9uX3ZhbGlkIGlzIHNldCwKYW5kIHRoZSBleHRlbmRlZCBpbW1lZGlhdGUgaXMgdGhl
IGZ1bGwgYWRkcmVzcy4gIFRoZSBwcmludGVkIGZvcm0ga2VwdAp0aGUgImdwKyIgYmFzZSwgc28g
Zm9yIGV4YW1wbGUKCiAgICBSMCA9IG1lbXcoZ3ArIyMweDQ4YzMwKQoKd2FzIHNob3duIGZvciBh
biBpbnN0cnVjdGlvbiB0aGF0IGFjY2Vzc2VzIDB4NDhjMzAgYW5kIGRvZXMgbm90IHVzZSBHUC4K
Ck9ubHkgcHJpbnQgdGhlICJncCsiIGJhc2Ugd2hlbiB0aGVyZSBpcyBubyBleHRlbmRlci4KCkxp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjExMTgxNDQ0NDEuMjc2
ODAtMS1hbmpvQHJldi5uZy8KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNr
LmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IEFudG9uIEpvaGFuc3NvbiA8
YW5qb0ByZXYubmc+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fcHJpbnRpbnNuLnB5IHwgNyArKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3ByaW50aW5zbi5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl9wcmludGluc24u
cHkKaW5kZXggY2YxYTEyYWRiYzEuLjFlYjk4YTFhNDMyIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4
YWdvbi9nZW5fcHJpbnRpbnNuLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl9wcmludGluc24u
cHkKQEAgLTEyNSw2ICsxMjUsMTAgQEAgZGVmIG1haW4oKToKICAgICAgICAgICAgIGJlaCA9IGhl
eF9jb21tb24uYWJzaW1tcmUuc3ViKHIiIyVzMHgleCIsIGJlaCkKICAgICAgICAgICAgIGJlaCA9
IGhleF9jb21tb24ucmVsaW1tcmUuc3ViKHIiUEMrJXMlZCIsIGJlaCkKICAgICAgICAgICAgIGJl
aCA9IHNwYWNpZnkoYmVoKQorCisgICAgICAgICAgICBncF9yZWxhdGl2ZSA9ICIoZ3ArIiBpbiBi
ZWgKKyAgICAgICAgICAgIGlmIGdwX3JlbGF0aXZlOgorICAgICAgICAgICAgICAgIGJlaCA9IGJl
aC5yZXBsYWNlKCIoZ3ArIiwgIiglcyIpCiAgICAgICAgICAgICAjIFByaW50IG91dCBhIGxpdGVy
YWwgIiVzIiBhdCB0aGUgZW5kLCB1c2VkIHRvIG1hdGNoIGVtcHR5IHN0cmluZwogICAgICAgICAg
ICAgIyBzbyBDIHdvbid0IGNvbXBsYWluIGF0IHVzCiAgICAgICAgICAgICBpZiAiQV9WRUNYIiBp
biBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKQEAgLTE1OCw2ICsxNjIsOSBAQCBkZWYgbWFp
bigpOgogICAgICAgICAgICAgICAgICAgICAgICAgcmkgKz0gMQogICAgICAgICAgICAgICAgIGVs
c2U6CiAgICAgICAgICAgICAgICAgICAgICMgaW1tZWRpYXRlCisgICAgICAgICAgICAgICAgICAg
IGlmIGdwX3JlbGF0aXZlOgorICAgICAgICAgICAgICAgICAgICAgICAgZi53cml0ZSgnLCBpbnNu
LT5leHRlbnNpb25fdmFsaWQgPyAiIiA6ICJncCsiJykKKyAgICAgICAgICAgICAgICAgICAgICAg
IGdwX3JlbGF0aXZlID0gRmFsc2UKICAgICAgICAgICAgICAgICAgICAgaWYgaW1tbGV0dC5pc3Vw
cGVyKCk6CiAgICAgICAgICAgICAgICAgICAgICAgICBpZiBleHRlbmRhYmxlX3VwcGVyX2ltbToK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiBpbW1sZXR0IGluICJyUiI6Ci0tIAoyLjM0
LjEKCg==

