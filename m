Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E837BC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2S-0006m9-1N; Fri, 17 Jul 2026 15:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2Q-0006ld-9n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:15:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2O-00083s-SE
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:15:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGoCqM2478193
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XRvglzUbyC2Ww8q58tleaeYbLAgDEV8B5n9HheKhV5o=; b=GpUrGVwn1V9gKFJq
 RyIw1QviR0UflTYGDwDd7w3Xz/GllTSAjCfLx+uQ23HGuAMEa9LgF/vrBytyHFAX
 qS6tdKVomUsbOEl5CEKwjOCagDDt5qzvRulVo8qlpUcf84ijuLrL/lWfKqtLJh7m
 Q00rsJ4QFQymRBNzXaOQQ3t71XQgHPA7LJv2IAg+8RSTFAJssJRfPB28d0WgeSIa
 czx58ZmKqgl6vsqQPcU6rPcqAu/M0PeUb42EIBTOdsTIWYlCRLypVdux03p302Ma
 D+/xXPtZwGWN/XE9IinlXwwrS4RN+oCliH1jNr6XaoUnH4PeFM2BoU98XC62lzv2
 ErzGtQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfjb14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de842a1a9so7735209a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315755; x=1784920555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XRvglzUbyC2Ww8q58tleaeYbLAgDEV8B5n9HheKhV5o=;
 b=jBgrZyBQ50l19FHcUQASw8dD4lo/ilrhk4T11CgG7x4dKyH8coZAATiVpugcnvCXXg
 D09QUead6Fyb2CrJI17PGQHHFOm/6DdBJAgfuGp3okGjO1DOOH7SI7isLqqmzjAMppiY
 gaO7nVv56rZoq+LU8UDGIiIzk9CwGk89hyx9CVpO7hkOiyXAa/WMkNaugmom+a/Ul/YT
 fFQov12LUKaU2IFuPW8wVdhj0DnrYIVAF/x8BCYxJGjEwQNXZVbkukXreuFnjpLzVcnF
 xo4lB8G+RjlOelyLQrJ3Op+1oAWbqwu6MjHLbVXovGE3Fff6biZlOses/ZCRp4Nb1e6D
 5V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315755; x=1784920555;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XRvglzUbyC2Ww8q58tleaeYbLAgDEV8B5n9HheKhV5o=;
 b=qJvL6FuvGJ44hbvEUIt1HwIMQF2DZflys4fNZCBMF5DUBN7OmKdcpJH/JPub/dVeWf
 MHoublNbMIOAc9l/ihBIAxUnXO445smpEjnAz1qrNJGKNDMyiRj+Pr9MqvSGXCX+yg11
 IfCFsDm3CQ4vlAF7JUZm/5VtBSRj9c6ZFClcXyEg5bB4Pjia+nJG3UozYhYcAYh3PNXx
 3RRB0i5lBLegMHo3/XXE+Z0rGUyBbdJilFLRXjRb2BImGh137KBCPzryUW7O7cXAzU6X
 D9grRcPaS4j1jparT5eZQEw6vU39mOVq+1UqFH69OqVgL/WmhU7//zWp+ams2sxLwWAU
 IluA==
X-Gm-Message-State: AOJu0Yycz8FxHgG2RJxDveEKqEwjskxFSk7gUMzHOIt9fW/W08fQRC7C
 47dhpQxiY43STPmOXqCjU1wHnXPnYFJDfoDAxp6oXA4yR+LL1dN6LIp4mWrcrp2lqZ4qqFuox1o
 aMi4wO6PmpbOR7qUtu67DaVRS242Rw9GqhduE3H+wiA4UQ+fwZZgS/lKyV+gsiFZ4Yw==
X-Gm-Gg: AfdE7ckktUSBPnYjESAXKbEqbK8csf1wz+diGgx563eIp+edFykdaM5ryy4Chl8hIrx
 v6vQieZvDGEZyBLdDSpP4ytoCxhipH1UdIw0/jzQrQAFufPPIqlWT066/+Ezmy6oL6woU3qYSCG
 zbaypJCVrFicYH2fB8Iniqjii51+I1Pzg33k/J7dreT3jsmwFZxIBPFVWNTMjy7lQAUFi/I+m1o
 09QgLJB953V9arKsCm6c7vE2DB8yaooCcV7oXFs2qH119mNS/CNI+gMwdel+c+G+O+aIulerhs1
 NPK99dabO/ZfPyRWyvkaz1kzZn0Gr+GR9TW2sVHR6haN7tOnCQDUNPxlVVgpnSOXKD67QIkiOCU
 JqpbyN+ibL98765l4R4Zyb8Mjy4m50T4zWStUV9qA/aXigLGK
X-Received: by 2002:a17:90b:4b90:b0:38d:ee84:b1ff with SMTP id
 98e67ed59e1d1-38e4b5aad77mr3790892a91.40.1784315754782; 
 Fri, 17 Jul 2026 12:15:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4b90:b0:38d:ee84:b1ff with SMTP id
 98e67ed59e1d1-38e4b5aad77mr3790835a91.40.1784315754275; 
 Fri, 17 Jul 2026 12:15:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:15:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/12] gitlab-ci: build hexagon-softmmu to enable functional
 test
Date: Fri, 17 Jul 2026 12:15:37 -0700
Message-Id: <20260717191547.920048-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX0IBLUxj9aWfB
 nV//afCBUk+V02lhL6/iEY70CKRQU+Tv0rW3ve4k9zsMLZAfDc4/kG+/pb9KE6Em00VOhOq+jHg
 pd7FKupRQvyNK53kgUm9bvhBe8yLdX4H3z0mXixjLah33tvYnREMlDB73Bjzv1oXx87IsOHVGWr
 M/Z6R+tHm+LPOoRKg6dveLdKkwz5F/M7KbKM4uvJR28s1EMNb4CIOGG748RygKzWPDVZnhOYJNY
 Ok6weFnHVd0mu17qzC6EUK0bGmb3XHQsXJGryS3w8LX85etDER7jGMNRRTStrVhoBOj2GyAWlnc
 4dtCJLx61sp98PdwepAQB6xw/e/dq0hVJQc0G+fLYeg7mOuBkdEHuIHFSNrWdFYkT0605OTcb3O
 RWAO206Ajaq17/SRoVjAtGJmom4uesyoDq9fjsrtDPiZOUfzUcn8Xtkt3Nwg3b1momsrPQ+fVC+
 bvgif4JNWPadAN8JBMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfXx/3vgQ0tVBRt
 Xdba6g4lzE2HJpt4yu/xV83FiHHNV2OxdyuwFxx7OG9NgpdD+r3+zOefDULPnMNHuaZpQBgZtLT
 LcPf6PrYiOKAm4a4Oxmadt83KuRI4F4=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a7f6b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AQ9b_f4qHiFF19MPkWIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: dWUBvbo7kl_tcUUs598U3gNRH6gZSpi9
X-Proofpoint-ORIG-GUID: dWUBvbo7kl_tcUUs598U3gNRH6gZSpi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

QWRkIGhleGFnb24tc29mdG1tdSB0byBidWlsZC1zeXN0ZW0tZGViaWFuJ3MgdGFyZ2V0IGxpc3Qg
c28gdGhhdCB0aGUKZXhpc3RpbmcgZnVuY3Rpb25hbC1zeXN0ZW0tZGViaWFuIGpvYiBwaWNrcyB1
cCBoZXhhZ29uIGZ1bmN0aW9uYWwKdGVzdC4KClJldmlld2VkLWJ5OiBUaG9tYXMgSHV0aCA8dGh1
dGhAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIC5naXRsYWItY2kuZC9idWlsZHRlc3QueW1sIHwg
NCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhLy5naXRsYWItY2kuZC9idWlsZHRlc3QueW1sIGIvLmdpdGxhYi1jaS5kL2J1
aWxkdGVzdC55bWwKaW5kZXggZTI1NTNlNzMyNmYuLjgzMWQ5YTI2NzQyIDEwMDY0NAotLS0gYS8u
Z2l0bGFiLWNpLmQvYnVpbGR0ZXN0LnltbAorKysgYi8uZ2l0bGFiLWNpLmQvYnVpbGR0ZXN0Lnlt
bApAQCAtNzAsOCArNzAsOCBAQCBidWlsZC1zeXN0ZW0tZGViaWFuOgogICB2YXJpYWJsZXM6CiAg
ICAgSU1BR0U6IGRlYmlhbgogICAgIENPTkZJR1VSRV9BUkdTOiAtLXdpdGgtY29yb3V0aW5lPXNp
Z2FsdHN0YWNrIC0tZW5hYmxlLXJ1c3QKLSAgICBUQVJHRVRTOiBhcm0tc29mdG1tdSBpMzg2LXNv
ZnRtbXUgcmlzY3Y2NC1zb2Z0bW11IHNoNGViLXNvZnRtbXUKLSAgICAgIHNwYXJjLXNvZnRtbXUg
eHRlbnNhLXNvZnRtbXUKKyAgICBUQVJHRVRTOiBhcm0tc29mdG1tdSBoZXhhZ29uLXNvZnRtbXUg
aTM4Ni1zb2Z0bW11IHJpc2N2NjQtc29mdG1tdQorICAgICAgc2g0ZWItc29mdG1tdSBzcGFyYy1z
b2Z0bW11IHh0ZW5zYS1zb2Z0bW11CiAgICAgTUFLRV9DSEVDS19BUkdTOiBjaGVjay1idWlsZAog
CiBjaGVjay1zeXN0ZW0tZGViaWFuOgotLSAKMi4zNC4xCgo=

