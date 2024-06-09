Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F0BC25B76
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 00:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG6sD-0007k3-Rz; Sat, 08 Jun 2024 20:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sC-0007jo-Jh
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sA-0003tP-69
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458MxaYo008607;
 Sun, 9 Jun 2024 00:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8lIN+ZmPVHJf317zaz7DXJBQyUma2FK7tT9eAnk9pLU=; b=hFpwaH3pfNG8o8dD
 g60Rfn358HDe/NV8Gk1PpCEwixVSq2l4xIApCx89fjW/e2pl/MM6ynaLF6cEcBR2
 dN8mwitf/xubuPr2X8P6mmwQrKquoK0OQ8YPECYz9dJKt7OZ4M/7u5WctDr8fLhx
 W0jCSx4mvudgdS/GKoOyZZiuBh+ozcNKk6K6IAQocxWpNxaGEYG0CZi0ts+jH9ok
 W0Z2hkYwVeXwbttcct7kQI8k84fA01CUEVsou779BsR+8iMZu51l2kAbqhd/JhFf
 rw29Rl9+X9F4RINFTunkHvgYcT4epQtOPY4OUXK6nNnNJUge59191n0hf6LZMixD
 PpbVZw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnms9j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 00:57:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4590vLrq024413
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 9 Jun 2024 00:57:21 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 17:57:21 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 4/6] target/hexagon: idef-parser remove undefined functions
Date: Sat, 8 Jun 2024 17:57:03 -0700
Message-ID: <20240609005705.2809037-5-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609005705.2809037-1-bcain@quicinc.com>
References: <20240609005705.2809037-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: IDBwS8kKwsaBekt-AThoooVEUi2kifGk
X-Proofpoint-ORIG-GUID: IDBwS8kKwsaBekt-AThoooVEUi2kifGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=815 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090006
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KClNpZ25lZC1vZmYtYnk6IEFudG9u
IEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRh
eWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVp
Y2luYy5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDI0MDUyMzEyNTkwMS4yNzc5Ny0zLWFuam9AcmV2Lm5n
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJn
ZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5oIHwgMTMgLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmggYi90YXJnZXQvaGV4YWdvbi9pZGVm
LXBhcnNlci9wYXJzZXItaGVscGVycy5oCmluZGV4IDdjNTgwODcxNjkuLjIwODdkNTM0YTkgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmgKKysr
IGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuaApAQCAtMTQzLDgg
KzE0Myw2IEBAIHZvaWQgY29tbWl0KENvbnRleHQgKmMpOwogCiAjZGVmaW5lIE9VVChjLCBsb2Nw
LCAuLi4pIEZPUl9FQUNIKChjKSwgKGxvY3ApLCBPVVRfSU1QTCwgX19WQV9BUkdTX18pCiAKLWNv
bnN0IGNoYXIgKmNtcF9zd2FwKENvbnRleHQgKmMsIFlZTFRZUEUgKmxvY3AsIGNvbnN0IGNoYXIg
KnR5cGUpOwotCiAvKioKICAqIFRlbXBvcmFyeSB2YWx1ZXMgY3JlYXRpb24KICAqLwpAQCAtMjM2
LDggKzIzNCw2IEBAIEhleFZhbHVlIGdlbl9leHRyYWN0X29wKENvbnRleHQgKmMsCiAgICAgICAg
ICAgICAgICAgICAgICAgICBIZXhWYWx1ZSAqaW5kZXgsCiAgICAgICAgICAgICAgICAgICAgICAg
ICBIZXhFeHRyYWN0ICpleHRyYWN0KTsKIAotSGV4VmFsdWUgZ2VuX3JlYWRfcmVnKENvbnRleHQg
KmMsIFlZTFRZUEUgKmxvY3AsIEhleFZhbHVlICpyZWcpOwotCiB2b2lkIGdlbl93cml0ZV9yZWco
Q29udGV4dCAqYywgWVlMVFlQRSAqbG9jcCwgSGV4VmFsdWUgKnJlZywgSGV4VmFsdWUgKnZhbHVl
KTsKIAogdm9pZCBnZW5fYXNzaWduKENvbnRleHQgKmMsCkBAIC0yNzQsMTMgKzI3MCw2IEBAIEhl
eFZhbHVlIGdlbl9jdHBvcF9vcChDb250ZXh0ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAq
c3JjKTsKIAogSGV4VmFsdWUgZ2VuX3JvdGwoQ29udGV4dCAqYywgWVlMVFlQRSAqbG9jcCwgSGV4
VmFsdWUgKnNyYywgSGV4VmFsdWUgKm4pOwogCi1IZXhWYWx1ZSBnZW5fZGVpbnRlcmxlYXZlKENv
bnRleHQgKmMsIFlZTFRZUEUgKmxvY3AsIEhleFZhbHVlICptaXhlZCk7Ci0KLUhleFZhbHVlIGdl
bl9pbnRlcmxlYXZlKENvbnRleHQgKmMsCi0gICAgICAgICAgICAgICAgICAgICAgICBZWUxUWVBF
ICpsb2NwLAotICAgICAgICAgICAgICAgICAgICAgICAgSGV4VmFsdWUgKm9kZCwKLSAgICAgICAg
ICAgICAgICAgICAgICAgIEhleFZhbHVlICpldmVuKTsKLQogSGV4VmFsdWUgZ2VuX2NhcnJ5X2Zy
b21fYWRkKENvbnRleHQgKmMsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWVlMVFlQRSAq
bG9jcCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIZXhWYWx1ZSAqb3AxLApAQCAtMzQ5
LDggKzMzOCw2IEBAIEhleFZhbHVlIGdlbl9ydmFsdWVfdGVybmFyeShDb250ZXh0ICpjLCBZWUxU
WVBFICpsb2NwLCBIZXhWYWx1ZSAqY29uZCwKIAogY29uc3QgY2hhciAqY29uZF90b19zdHIoVENH
Q29uZCBjb25kKTsKIAotdm9pZCBlbWl0X2hlYWRlcihDb250ZXh0ICpjKTsKLQogdm9pZCBlbWl0
X2FyZyhDb250ZXh0ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAqYXJnKTsKIAogdm9pZCBl
bWl0X2Zvb3RlcihDb250ZXh0ICpjKTsKLS0gCjIuMjUuMQoK

