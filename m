Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAD2C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphf-0002pt-49; Thu, 06 Aug 2026 00:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphb-0002pO-Cp
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphZ-0003Bt-5d
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675Nb2tr4063270
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=MZVK2LLmdlX
 d/zI9+68xbBAlTKUC63guUI6MzwvgBWM=; b=LehtTLGZMtoAOaQaRM3X1/FXrzO
 p1p/IZL3U36HW+EJwJAPPGutMFI5IjzXoD3TP76jKUzOuHO9dzZ1z66KRdBBrvLO
 onxB7RwUcwBDoqV6HmkYlXNAsB/Csz99GfYpsjlDKSSuArJIgLJxyU6on1Y3vrv2
 qxXGVix6F1ri/Ov0u0T7zk+fTnP6awC1pf+5GMNzm1cgImOEEjCasipsxxlE0MEj
 XWRGvVYnxcllml9gu/MDA7nq024I+zhYVhwAsXNwHsd6YYZI10GhZVYHzVWg4e1o
 d5e52/9TxpHPraJ5Pl05IxxENi40CtY3J/KTu+h1Quhp6Pqf+bUC1lw5wiA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5kg9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so2860632a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990446; x=1786595246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MZVK2LLmdlXd/zI9+68xbBAlTKUC63guUI6MzwvgBWM=;
 b=IOROlGFfMR1+SLeVLIe0FzCWxWQ943b7qlz79Mk4yTdI0zeqwmY6PK0XcimOc3Ksw4
 ZbuG4XVrXbgZGlOBrwS/U4a6yKsBE+kgEICFJweiFrxs97d6OUEBay1snTGbmHWMCaK7
 aHKcE8VOrj7uwEw1w5Bl0J9dPr1bcET9JOWo5XkOgujGqcriY7BxL2z7tx5x5Z0uQyvn
 +LW43A5MmzayadBqqxHsT7nYQa3Bd5vxNZvCSVq81ep6sEgRB9XqhSzM7kCLhqhq/aFM
 fZEV5UbWTi/COH7HheTRk7UJ/N7eo+PpcAym+iSGJNupMdqM+uBsqP1umESYtlAsz624
 F+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990446; x=1786595246;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MZVK2LLmdlXd/zI9+68xbBAlTKUC63guUI6MzwvgBWM=;
 b=c11uWMqWncpYTPAWG/u9olxB3ayHKnP/K2GNrFvMv9sgqnhdqS6DyKYorpCEwbW64F
 +y42yKUCs35YFMSb0+cnme4NnkAasjxmnd0pFRyc+4yoO5Il56LQNPj5qOcK/cGubfNW
 qZsDLfpf3t/GCAq0JIHni4c2XrFjid1jqSV6PgzuvSrQO/6cHbJNvnrdPAsww3mjxkxt
 Z9F7805xlVpIVKt67Te6qJrQFVGaRg4ccXLiYeqJs2i/HIkn15T2RSIvuT9JVxCuj7s/
 xDcf+UdJDzKyieQ2eHGfbdL5xxnH2UsBqGKEdxij2loOhuI3248CF6CoBB4g5mtuySUa
 l9GQ==
X-Gm-Message-State: AOJu0YxL6V6jzplgTjtRTfT6qCzFwQdclnr6i9Kb5ELKQZIbpNO0p6jS
 U9blkujTMhaNTnXmSENVZANzBViICJKfjqTRC4YLRxQn7WY35QdwOPLcSw08+/gm9agg3HllvDC
 HPzBtYsBDbufvdxlLnu5E+ApjfL6GxbKnDlHz31f8gXCcn1XLjG0Q5nUwq+spUsOzUQ==
X-Gm-Gg: AR+sD10CmePcB6AsaCdaoFARmnFg7owCnUbL2PVn/xgZqyCXJzf8ZzunILqSX8LaHhB
 PLMwYneXPOsOwUOrzHSCcqT4E4gZrrsGtKbqVeSwP0BY5+CNw0M6+TKkjvQWpI0AavZcVOHtSS4
 QWy1jFoWizjslzPCYS42w7RDfD4RoJ4jI+hMvyZIZfQPOKKlkeNH6zbcAqGepSvY1I5JeYxsdJo
 puQLYRheFqT1yqj0sr0CfIrdOrcRlhk8iSpYKW6l2XMvQt/WhYggQxFvxHGPgFlrxp8C6ZC2wrs
 5zGLEooqlpefI5rfl6gcpCuLqn14VAwmSUwJJyUG3FLuNjq9hPWXifjOicFUzDcdCTVWXcG4RdF
 T+hezL9woOKFzExSrihCwFC1lAxPrShffhmPbLfiZa0rhI9VB
X-Received: by 2002:a17:90b:280d:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-3903c54fbebmr13715200a91.1.1785990445701; 
 Wed, 05 Aug 2026 21:27:25 -0700 (PDT)
X-Received: by 2002:a17:90b:280d:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-3903c54fbebmr13715145a91.1.1785990445250; 
 Wed, 05 Aug 2026 21:27:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 00/18] Add hexagon l2vic, qtimer devices
Date: Wed,  5 Aug 2026 21:27:05 -0700
Message-Id: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX35cRqlUQVJRd
 AGfgYdNmEHdeKKk2XJpsMyk0DKABSuV+LjcohdjozYfWYubb/jA+iYMgvyYf527fzfVBD1bqlZg
 l7Uvq7EXSgbDE3aVrsuJqwDYLJbbimx6OFugT+A7OLBU16rKNYIgGeXgEOhNxV3bM5dg+D29Nwt
 RmqLmcYxhtSuViXP/vMqQgqXN9s0znqHklh/+Cy/xSqpwE3Tk+DvXz7haQAetbQHEgpZYg8YMjM
 IXoZjHI97Xufnf/98fIz9rRR+oDK8ENR57zdXliQvFSnDFBM+8SYgqP5oG7C/46xK4A6tYGlLn5
 Kw9H9YVdmsQG4MhcZncXgBqVrEozvD/HzEix7uRBq6xD9fN+k7q6sQvsfw7PWt02uUfYl/YbA8/
 fP445mbcYCg9MPmzMOaJ2oSSV1BD1RBsBeWYbPJsh10Q1zMXRYltWCXlgg/uwiZ7P83bh6Vh5Ob
 s/kyTzHoENCC9uvmydA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX/Bkpg9uMMmOv
 5MfXJozzp10aE3+Yp7d6m3LW3DfssZz7TFZlEDOdemc50G4LZEPZxTq6x8Z8h+m04HwIlKYYO27
 YQkVc6H88V4a4F222iyxDhhKLOg6MEw=
X-Proofpoint-GUID: -H6LIyoRj7nJba0E0ufeqwd4Tf3EXpa9
X-Authority-Analysis: v=2.4 cv=cIbQdFeN c=1 sm=1 tr=0 ts=6a740d2e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NaEdWPjXbSEPp-aJk_cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: -H6LIyoRj7nJba0E0ufeqwd4Tf3EXpa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060030
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

VGhlIHByZXZpb3VzbHkgaW5kZXBlbmRlbnQgdGhyZWFkcyBmb3IgbDJ2aWMgYW5kIHF0aW1lciBh
cmUgbm93IGNvbWJpbmVkLAp3aGljaCBzZWVtcyB0byBtYWtlIHRoZSBtb3N0IHNlbnNlIGJlY2F1
c2UgcXRpbWVyIHRlc3RpbmcgZWZmZWN0aXZlbHkKZGVwZW5kcyBvbiBsMnZpYy4KCkNoYW5nZXMg
aW4gdjU6Ci0gYWNjZXNzLWNvbnRyb2wgY2hlY2tzIGZhY3RvcmVkIG91dCBpbnRvIGFjY2Vzc19v
aygpCi0gcWN0LXF0aW1lci5jIG1vdmVkIGZyb20gc3BlY2lmaWNfc3MgdG8gc3lzdGVtX3NzCi0g
Y250dGlkX3swLDF9IHZhbHVlcyBkZXJpdmVkIGZyb20gbnJfZnJhbWVzCi0gdGVzdCBjb3ZlcmFn
ZSBmb3IgYWNjZXNzIGNvbnRyb2wsIGlycXMKCmwydmljIHY0OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjYwNzMwMDEyODI0LjExMzU5MDUtMS1icmlhbi5jYWluQG9zcy5x
dWFsY29tbS5jb20vCmwydmljIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzIwMjYwNzI0MTgzNjQ4LjE5MDUzMS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KbDJ2
aWMgdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA3MTUxODU3MDEu
MTI4NzE3Ni0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KbDJ2aWMgdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA3MTQxNTUxMjYuMzUwOTU0NC0xLWJyaWFu
LmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KcXRpbWVyIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjYwNzE4MDEzMjQxLjE1NTAxMjQtMS1icmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20vCgpCcmlhbiBDYWluICgxNyk6CiAgaHcvaGV4YWdvbjogYWRkIGhleC1zdWJzeXMK
ICBody9oZXhhZ29uOiBtb3ZlIFZUQ00gdG8gdGhlIGNvbW1vbiBtYWNoaW5lIHN0YXRlCiAgaHcv
aGV4YWdvbjogbW92ZSBnbG9iYWwgcmVnaXN0ZXJzIHRvIGhleC1zdWJzeXMKICBody9oZXhhZ29u
OiBtb3ZlIHRoZSBUTEIgdG8gaGV4LXN1YnN5cwogIGh3L2hleGFnb246IGdyb3VwIHRoZSBDUFVz
IGluIGEgY2x1c3RlcgogIGJpdG9wcy5oOiBBZGQgZmluZF9maXJzdF9iaXQzMigpCiAgaHcvaGV4
YWdvbjogZXh0cmFjdCBnZXRfcmVnX3ZhbHVlL3NldF9yZWdfdmFsdWUgc3R1YnMgaW4gZ2xvYmFs
cmVnCiAgaHcvaGV4YWdvbjogY29ubmVjdCBsMnZpYyBkZXZpY2UKICBody9oZXhhZ29uL3ZpcnQ6
IGluc3RhbnRpYXRlIHZpcnRpby1tbWlvIHRyYW5zcG9ydHMKICBody9oZXhhZ29uL3ZpcnQ6IGFk
ZCBsMnZpYyBpbnRlcnJ1cHQtY29udHJvbGxlciBhbmQgdmlydGlvLW1taW8gRkRUCiAgICBub2Rl
cwogIGh3L2hleGFnb24vdmlydDogY29ubmVjdCBwbDAxMSBVQVJUIGludGVycnVwdAogIHRlc3Rz
L3F0ZXN0OiBhZGQgTDJWSUMgcXRlc3QKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCBh
cmNoX3Rlc3RzIGZ1bmN0aW9uYWwgdGVzdAogIGh3L3RpbWVyOiBBZGQgUUNUIFFUaW1lciBkZXZp
Y2UgbW9kZWwKICBody9oZXhhZ29uOiBjb25uZWN0IHF0aW1lciBkZXZpY2UKICB0ZXN0cy9xdGVz
dDogYWRkIHFjdC1xdGltZXIgcXRlc3QKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGVuYWJs
ZSBtb3JlIGFyY2hfdGVzdHMgY2FzZXMKClNpZCBNYW5uaW5nICgxKToKICBody9pbnRjOiBBZGQg
bDJ2aWMgaW50ZXJydXB0IGNvbnRyb2xsZXIKCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA3ICsKIGRvY3MvZGV2ZWwvaGV4YWdvbi1sMnZpYy5yc3QgICAg
ICAgICAgICAgICAgfCAgNTUgKysKIGRvY3MvZGV2ZWwvaW5kZXgtaW50ZXJuYWxzLnJzdCAgICAg
ICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleC1zdWJzeXMuaCAgICAgICAg
ICAgICB8ICAzMiArCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgICAgICAg
IHwgICA2ICsKIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5oICAgICAgfCAg
IDggKwogaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaCAgICAgICAgICAgICAgICAgICB8ICAgNCAr
LQogaW5jbHVkZS9ody9pbnRjL2hleC1sMnZpYy5oICAgICAgICAgICAgICAgICB8ICA2MSArKwog
aW5jbHVkZS9ody90aW1lci9xY3QtcXRpbWVyLmggICAgICAgICAgICAgICB8ICA0MyArKwogaW5j
bHVkZS9xZW11L2JpdG9wcy5oICAgICAgICAgICAgICAgICAgICAgICB8ICAzMCArLQogdGFyZ2V0
L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiBody9oZXhhZ29u
L2hleC1zdWJzeXMuYyAgICAgICAgICAgICAgICAgICAgIHwgMTc1ICsrKysrCiBody9oZXhhZ29u
L2hleGFnb25fZHNwLmMgICAgICAgICAgICAgICAgICAgIHwgIDQ1ICstCiBody9oZXhhZ29uL2hl
eGFnb25fZ2xvYmFscmVnLmMgICAgICAgICAgICAgIHwgIDY1ICstCiBody9oZXhhZ29uL3ZpcnQu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMwICsrLS0KIGh3L2ludGMvaGV4LWwydmlj
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA1NTYgKysrKysrKysrKysrKysrKwogaHcvdGlt
ZXIvcWN0LXF0aW1lci5jICAgICAgICAgICAgICAgICAgICAgICB8IDY2NyArKysrKysrKysrKysr
KysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MiArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDE2ICst
CiB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAgICAgIHwgMjQ5ICsrKysr
KysrCiB0ZXN0cy9xdGVzdC9xY3QtcXRpbWVyLXRlc3QuYyAgICAgICAgICAgICAgIHwgMzg1ICsr
KysrKysrKysrCiBody9oZXhhZ29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAzICsKIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
KwogaHcvaW50Yy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBo
dy9pbnRjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGh3L2lu
dGMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogaHcvdGltZXIv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBody90aW1lci9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGh3L3RpbWVyL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8ICAzOCArKwogdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogMzEgZmlsZXMgY2hhbmdlZCwgMjUxMiBpbnNl
cnRpb25zKCspLCA5MCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL2RldmVs
L2hleGFnb24tbDJ2aWMucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9oZXhhZ29u
L2hleC1zdWJzeXMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2
aWMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvdGltZXIvcWN0LXF0aW1lci5oCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9pbnRjL2hleC1sMnZpYy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdGltZXIvcWN0
LXF0aW1lci5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvbDJ2aWMtdGVzdC5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvcWN0LXF0aW1lci10ZXN0LmMKCi0tIAoyLjM0
LjEKCg==

