Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1FEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 04:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLx8o-0006a1-7Z; Thu, 12 Dec 2024 23:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8m-0006Zb-10
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8j-00082S-Vy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:18:59 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD45l4Z017226
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oeZymPizFa0qe/MJmWN1Ex
 GS3y+RIumBJbE1fJNtapM=; b=pqvBvBsqdZ/iAZay4I9JkjLD7XtcW2C6IYSjBD
 xXLPVdtgBS5ZTYaSsaTA0DzEy+UakSR55pS1rvaFn+tNFCeVYz1je3nYG/fDqqZy
 5gIdiQ3TLZN4lZ2osHQfk20k0RnCKO6Jw9anZMRMwwwcUVohdjNHAnlO2qPR1oYu
 TpghWiY7hkysIXXGEjgCmWb0+lUeolLqOjuM2eNz4MFgA1Pe6VukLvQhYdujc31O
 y2jfGoDY0MOTMoSYBSXnqsJf8xMwVDNXtBDK8vl2SjVXRua2XFP2H6bMFoEy1rPm
 Ya1C7rx8Tk805MxMBlSF7tdCFYpMNluk4ZdXHwiJvwrgycUQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gdkn00r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-728ea538b52so1942652b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 20:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734063532; x=1734668332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oeZymPizFa0qe/MJmWN1ExGS3y+RIumBJbE1fJNtapM=;
 b=YKa6pUOMapkc+5bIqCJDy+ZnGfHqbs02LbpX1ybJ/i+tysgAm/RD1TMNjBFcHJHIGw
 Md7/X9vWeu8Ga0VDvEBT2XpayhaqyLuEwE9F4i/df0BvcnK6UQCIYy4+JzI0TmXGw3Gp
 1RU0iuhGv86dKFK3A/Om0pRo/pQ86+co7MJT+lscl33TJqUQkvw1nsxB3l/ayOY5UHO/
 NM0k9Hz4QNxak5c882PljSQ2knvM1ltcCssPBsMe/ZuY37lZ8gBiDCnwrt1pVaKPzUf5
 wHi0hVedwqVsi707Ktg+y2ocAcPk5YTi+PEMcTtIc2ZIhTOrrGHgc7rJiqMd4zmtXpbx
 lGDg==
X-Gm-Message-State: AOJu0YxCIFWxRqaUs89Mojs97SJQHiDMDtYMoPvdAjjXRV8k1WrmUp5v
 5/JCsRM2Rd+a4BsZ1MTnd+4N0/07n+4kQWdTcPZLdzI1TWz3mb1C8fT1zNY3VY4fcfWD3uAwLV7
 QGwgKPZobCE96gwFWnApJ+2tWMrqu12+Fq6w6GyCGWjqz84PdeWb7cvupwR2HPg==
X-Gm-Gg: ASbGncs19u/QRiTXaAQCRgy5Vx8eZW8TLa01koE8Ss5xy5oLVRWRFP+ZUHcZg437Ygi
 i61ZGcrWRiFOPrD345Jal0/EB3MEsOBzSwGGo6CEBjonoF8kK4TDeeKCHnMqlYbPFju0rDgrfZv
 D5RJjqX5iGaG8bn9lP6cDZpFJKEYg8kKZ5aoYJBcfc2HI7R+ooKqQRXMMvChQe0PaGfnLDvL6iq
 ckQBYsWfrk1ZCSQ6GxJ2sR+XnkGmyHOQHd3vZoDpX3jt21PeueWCHhonfnrxt9ZoPWXXlkFrQf2
 6RDnL2XikeB4D/6VL8I7IZQjX3+Cww==
X-Received: by 2002:a05:6a21:150a:b0:1e1:a647:8a54 with SMTP id
 adf61e73a8af0-1e1dfd650f1mr1719587637.20.1734063531828; 
 Thu, 12 Dec 2024 20:18:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtH+IUhdWwFdvvI4uhUIcaPoyFjloBwGN5VYDX178tb7L6NIZ1aKjUAGofjCevfSaIDKpxxA==
X-Received: by 2002:a05:6a21:150a:b0:1e1:a647:8a54 with SMTP id
 adf61e73a8af0-1e1dfd650f1mr1719551637.20.1734063531403; 
 Thu, 12 Dec 2024 20:18:51 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725deac1daasm9451938b3a.171.2024.12.12.20.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 20:18:51 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, peter.maydell@linaro.org, 
 quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
Subject: [PULL 0/5] hex queue
Date: Thu, 12 Dec 2024 20:18:31 -0800
Message-Id: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: fyPNAuc40PqLE10tUiJcLkr2IYqrFFoo
X-Proofpoint-ORIG-GUID: fyPNAuc40PqLE10tUiJcLkr2IYqrFFoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=889
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhNWJhMGE3ZTRlMTUwZDEzNTBhMDQx
ZjBkMGVmOWNhNmM4ZDdjMzA3OgoKICBNZXJnZSB0YWcgJ3B1bGwtYXNwZWVkLTIwMjQxMjExJyBv
ZiBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjQtMTIt
MTEgMTU6MTY6NDcgKzAwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjQxMjEy
Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYjI5YjExYjUxZjFhYzE4ODRhNjRjNWI2
YmRlOTY5YTQ2MjA2MjYzZjoKCiAgdGFyZ2V0L2hleGFnb246IE1ha2UgSFZYIHZlY3RvciBhcmdz
LiByZXN0cmljdCAqICgyMDI0LTEyLTEyIDIxOjQzOjU3IC0wNjAwKQoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpSZW1vdmUg
SEVYX0RFQlVHLCBFWENQL0NBVVNFIGZpeGVzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFudG9uIEpvaGFuc3NvbiAoMik6
CiAgICAgIHRhcmdldC9oZXhhZ29uOiBVc2UgYXJncGFyc2UgaW4gYWxsIHB5dGhvbiBzY3JpcHRz
CiAgICAgIHRhcmdldC9oZXhhZ29uOiBNYWtlIEhWWCB2ZWN0b3IgYXJncy4gcmVzdHJpY3QgKgoK
QnJpYW4gQ2FpbiAoMik6CiAgICAgIHRhcmdldC9oZXhhZ29uOiByZW5hbWUgSEVYX0VYQ1BfKj0+
SEVYX0NBVVNFXyoKICAgICAgdGFyZ2V0L2hleGFnb246IGFkZCBlbnVtcyBmb3IgZXZlbnQsIGNh
dXNlCgpUYXlsb3IgU2ltcHNvbiAoMSk6CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBS
ZW1vdmUgSEVYX0RFQlVHL0hFWF9ERUJVR19MT0cKCiBsaW51eC11c2VyL2hleGFnb24vY3B1X2xv
b3AuYyAgICAgICAgICAgfCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL1JFQURNRSAgICAgICAgICAg
ICAgICAgICB8ICAgOSAtLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAgICAgICAg
ICB8ICAgOCArLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggICAgICAgICAgICAgICB8ICAy
MSArKysrLS0KIHRhcmdldC9oZXhhZ29uL2dlbl9hbmFseXplX2Z1bmNzLnB5ICAgICB8ICAgNiAr
LQogdGFyZ2V0L2hleGFnb24vZ2VuX2RlY29kZXRyZWUucHkgICAgICAgIHwgIDE5ICsrKystLQog
dGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSAgICAgIHwgICA3ICstCiB0YXJnZXQv
aGV4YWdvbi9nZW5faGVscGVyX3Byb3Rvcy5weSAgICAgfCAgIDcgKy0KIHRhcmdldC9oZXhhZ29u
L2dlbl9pZGVmX3BhcnNlcl9mdW5jcy5weSB8ICAxMSArKystCiB0YXJnZXQvaGV4YWdvbi9nZW5f
b3BfYXR0cmlicy5weSAgICAgICAgfCAgMTEgKysrLQogdGFyZ2V0L2hleGFnb24vZ2VuX29wY29k
ZXNfZGVmLnB5ICAgICAgIHwgIDExICsrKy0KIHRhcmdldC9oZXhhZ29uL2dlbl9wcmludGluc24u
cHkgICAgICAgICB8ICAxMSArKystCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICAgICAgICAg
ICAgICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY190YWJsZS5weSAgICB8
ICAxMSArKystCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5ICAgICAgICAgfCAgIDkg
Ky0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkgICAgICAgfCAgMTggKysrKy0K
IHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICB8ICAgNyAtLQogdGFyZ2V0
L2hleGFnb24vaGVscGVyLmggICAgICAgICAgICAgICAgIHwgICAzIC0KIHRhcmdldC9oZXhhZ29u
L2hleF9jb21tb24ucHkgICAgICAgICAgICB8ICAzMyArKysrKy0tLS0tCiB0YXJnZXQvaGV4YWdv
bi9pbnRlcm5hbC5oICAgICAgICAgICAgICAgfCAgMTEgLS0tLQogdGFyZ2V0L2hleGFnb24vbWVz
b24uYnVpbGQgICAgICAgICAgICAgIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNy
b3MuaCAgICAgICAgICAgfCAgMzYgKysrKystLS0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgICAgICAgICAgICAgIHwgMTEyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgfCAgNzIgKy0tLS0tLS0tLS0t
LS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAgICB8ICAgMiAt
CiAyNSBmaWxlcyBjaGFuZ2VkLCAxNDggaW5zZXJ0aW9ucygrKSwgMjk1IGRlbGV0aW9ucygtKQo=

