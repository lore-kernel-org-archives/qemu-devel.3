Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C10CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNd-0002fl-TE; Thu, 25 Jun 2026 10:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNc-0002fK-GN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNa-00008T-W1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jv4m025784
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=; b=N74AtR3H1uzOvL5h
 mGUkBgWAUwmhZmHCGqBIEHotZO6MudSWnQ/DsVTQXov+SRcolrCwVSHB0C+kCanX
 6azwB1ESX7NfE4qbpUIFIM8YcmSieVjYUhp9Za7DR4UIE4YECh3ACGealhtSHgM0
 lSxYES54Kkp/GS7JIKh7rS+vDmYNsLjh9O+J19HyfOt6y4mC10fhrdJJZsH1ST64
 iFAY3m0aNhTrEiQVpAY5eKfdDb3g9QIo1EOl5H6RXKDCyJILulc5rRCtcWOKKzBM
 psYLlO1pRqLjkkDjwNrrAFWHfkNdCwgKqfUxq3qxSlJrnct3MjyfUlJ/xi4dwsqY
 2lIMlA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0tsptx5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so7003057eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398913; x=1783003713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=X4GyVzoM9oFC/kLa48IcfCcky24+ntXjwJd5ghdgRFIPbRaYMNEZW1n1NbTBKvDszW
 gukAJ9Fk7l53INC5zzH0rLTgzyPTQnKNnI8/fAugbPKVOSPMXyypIS3Mhf/7g/szJBB/
 YXdrV29TVNdB+eOmiWJXzrEOJynTjqU1Yq3LgtXnIQLQXfeSpKuPs9KeLbAMh6aAWofw
 l6NVdS7TyeYvBVjEX792+nYZybGLi2o7FB34Vcgr4ER3NYXXCzev0PNprWDXaPGHv8tQ
 UjNNkFTNlKFfCcuUBdQzSBs4FYGhSHuHGn+z3Lv/qg/FMMM8LfJ0UDgJv8YdmGl+7N0y
 APNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398913; x=1783003713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=FgLbuw/jUwurZYmf3JZHoaOayrXwTzMXum2Yzx1gie7W9hEhkdqoc5LCf/2kDa9ZYH
 /HSBoNwLNbubw0fE+IFMC3ESr+rj/oVvgFpLmJIARpihCsvEV2Pv5BHFPrcz9NBMGCSp
 LB/qwSy/WIxOOhP/4tJjYtLejmXNzUt1bIEABZLytZu6+Mc7sz0NR1WPPQNyMhiCoWrH
 +o4a7CveLCLhmyHRGwbqgflrvgj8phBFExtYaK5dp4Nta9etXD1ZueSYCecbmH7agE8z
 ZKLmSFgjOqfxBTArFHRwIlKfeUXjTsJaifZbJhDa1k3qmIYfqflvOZJVQ2gVhGz+M5QL
 LXbA==
X-Gm-Message-State: AOJu0Yz2S12tASCVxBkAXV1q9qTFPpHPu4OWILm0psuF9fQXiI68HTZj
 jn+F/Vi4w+kIKJBjaUH6+IMtwhHoadgOT0bcdjZY8g2PCFIom2p8r0RNV8KrXUPQZ5aP+ALkVw3
 WW3a/ZAVtD2LjFKjlXentvzr3ITEOnuX3mUNE1s6oHsh/2huW9RDwHT2Kn01OublDTw==
X-Gm-Gg: AfdE7ck1Ep5lZApMvTaJr7D3F453+/h8hETklvSu93/yKrZjPQNWr1RSy0T8OoAa0pF
 VoQi36oKHEwzLXHPZqJRLxAuWMJ9VJM+sujbt8dWB/w7XKWEWsKoPyAaP3zC5WLYyRMs7NoyKi9
 +k5zo07oL8GIkrq8ujwqqFNSKtr0lTclvfdF4Z20JjuQMsc8goXleSt3SwgL62od8ZjThp/qodm
 j/+sjh5LpIQriWEKAbdsp2e/t41mW0kJATYPOnfXZC5exdClw7/t/wu+eJ02WGq4C/mWo+3UYhL
 iSx6H1PBpWwu3LkfSALi61wqyjsh4p8WQKev/AOaqUuHPDQ7sFGIk7wbpuQRZgfhtqaaFV2wLHm
 el5tLMUX/GBuViYWY0N7lKEyo0+HfMUiP6bE57gSwPmYvppntI6jiY7P6zO0=
X-Received: by 2002:a05:693c:6383:10b0:30c:8d9c:78a with SMTP id
 5a478bee46e88-30c8d9c0d06mr1113590eec.19.1782398912840; 
 Thu, 25 Jun 2026 07:48:32 -0700 (PDT)
X-Received: by 2002:a05:693c:6383:10b0:30c:8d9c:78a with SMTP id
 5a478bee46e88-30c8d9c0d06mr1113566eec.19.1782398912235; 
 Thu, 25 Jun 2026 07:48:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 56/76] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Thu, 25 Jun 2026 07:16:13 -0700
Message-Id: <20260625141633.449487-57-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=OL8XGyaB c=1 sm=1 tr=0 ts=6a3d3fc1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXx6YEoIR5ofpV
 Dfj9xZAjAdh9qw31XUcIuthgGdejLCwTfGfJJ1qw2mjtFkRZStGlCEs0oc4oz3ll4lXoRXQw6Tx
 PV9jbcMHDjyMmJpQg//yibemudX8hGK03D7KWnY5Z1vamvVSzjElN4O9+70vKK8M1a8rL7wGUIg
 QtgBAdxTEgmkOWh+YYcsMFnR52ZJ1maMhx+Ea995qYOmhpN6FDqt16eY6xQs2LkdW7AFxwZKZTc
 3Y4PjeizZcjVDwF7LOdDVtEZRIWW/WVWk67R9P36hpUWGiYgG4E+i0zpYWX92r/cEgIOClzDXSF
 F2NgZn5UQQZ10YYjsYq1/HdfMLCS493xh7TA7ZjD0ORwHi2S2+kLZ8N7eH5Z1YjS8D/8lOlU4tR
 FSUyN5tdblv8eZuENMyCwvb3Ed/xOsALU+k44/GM2rNn95ODgR3GPT8k8hn6xysswCxj9uHEMTz
 iEkeZv/HiXUgAEs6h3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX243ID/SJxLAV
 3jCf+JXjhBabxaXiHNmaA+ye9o4GJy6iy1xoFiwg0VhMOpIpjY3GRWEaVKa2p7+ER98b/xThGxF
 RfEsG5t2LRjhqmc99w4J9Bwwz/1WN5Q=
X-Proofpoint-ORIG-GUID: E-IYkoCtrgwXxxNR14xEIFgCDmXmxwLg
X-Proofpoint-GUID: E-IYkoCtrgwXxxNR14xEIFgCDmXmxwLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNjcwNjY4ODA4YTgu
LjNhZjkwZTMwYjBmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ3LDYgKzQ0NywzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

