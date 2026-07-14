Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68853C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfPz-0000xL-4D; Tue, 14 Jul 2026 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfPy-0000x2-Au
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjfPw-00013o-ME
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:51:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcNCX800181
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=; b=VYyouABV2y39JRG7
 9e+NH1yvmqgbeBtoz0lWtU4+bUtt5JQi7XFYiwbEVYXPwP2e/j9kU+Pqsp4phudj
 ErCQZ8bSyEBi9pBhhWli7gKQ7jfV7nQfGFJLdx1vy7aEP+PSkZciRe1N+0Gy8HN2
 cG4lv07mjCwnrSo+1CzMaRkw13jxDhhrzhfJuiQCo1y7J9O3NaiWRN1ur5k6gsvW
 fnya3RobxxrfyxF+wLaUugb0O3VH0raT31pkNu5gL5qrro7LdLXRKbJI6s/J8nof
 hzcohtYcmdyWzTmpva2OO/d7LNJw1iGpggT/7uv5MQhuFXepK501GingUYt+V2G9
 6YEt5A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr0r02-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:51:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so5230307a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784044289; x=1784649089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=;
 b=M/8y+yLbqzGvWKM6TEnjmF0lj7IQdSJUrc4FBCJjbzhCbmhG8lzhz4QOBJhVOvHgL5
 WWBRiRkSkBb6PcsSzQnnZE+6shomuakmWwHeUZiNgHQWKle0bgjEe7k53JkVy7V8aJ2J
 zmlmjvoLarcqppMgv2uFpQCo9Q+DndLae1jHg3kVZ0K1+ONKmJH152ls4xJ/qea5yRX4
 D6ms+uSOMEG2IOJghGwDhzaAgQ6pu4684jqJ0DYatVKYwvtlYAo+NMwns0KQgdFH92Kf
 Z9XgnRbcjsmDQjoOyNTl55J8dFCM9MZ1v5Zq56R0KEnUc9yzRicbjzEmRG8tQji7p1aU
 tmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044289; x=1784649089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMDDgULMPaXVsCQN/OjK/Qlh+8CwP1mRe2DYbS8FB9M=;
 b=CITOMh0gIvu8Xd1CgTwjleQQZR/xerPp2XiKag+bO1mVJp4/is0O1EBJTmGu0uioPX
 oh27eqZM/Iv0+k19lwvU/ROX+dlUqd8vpTR2s/WiWLfA0Za4gFGbu52dxiOOs8+vLRyp
 WKvv6qMTKJBz4xQ2CaAN7H6ke9XOaITV4PdliYpmO7IHkc2Mcoro8he0jzyNFVz07YNC
 QYdjZSmmR6WXGV/Cd2xrYAwPa7X3jBFWiM+ODnJUUJweFw9Th6zm4xlBW3/6toDe43jX
 d99ZUSQ90UBqqmZlPNP1TanMxNq4mBqfjE3eAMxNLWlbn9ke1Qk47/fciDkeLwhoGZn8
 a7yA==
X-Gm-Message-State: AOJu0YxU78sw7taKpMdSjhG4TWE7TJz18ULuKZf5S+TDa08Ldz+QIQ83
 zVhBchfwfQPb/k0w3o2WchW1TfJ7z3bhBMvYRd0k9TnbHuZdtta9osNg4i3vfeOmmAShH5sslWI
 gMCrddNc4y8is8OYLQR6ksxZoy5PrloLCR1q94xYybHEPcZA1SJMwVDZw80uYNBpKEQ==
X-Gm-Gg: AfdE7ckCUcxN5wtc0aweptTRW+EGmxXm7Y5Fy3nKlWHuHTfq9VkhTvleMTA2oXOjpaG
 zriXwOZwZPVY9CZ3D2nmRDLGTrRx6FgX86sfm54Vaii1duNX0QGRqqqNehOTSa/clJBrj5rc1ou
 YnpX+Iu3EC3SyzUpunnfH1arq8Hn/FyOLvopfwFTT4O2fUj1miguDyeOzy4gbLiPgHcI7PUtr45
 VKaIkz20gPxg7Dlee6Zn5ErpKFrQJXQsAqDE8b/ml1rhbyrpzvs4T8pRzpmKn8P0S76+pnTPhyR
 UX+Id5QYhLF3Uxe1u+n9mVoq58qup92lqQmpv5SdKfDuttpnOb8rBcLDUe7ZL5B9yqd31RAS5i+
 g6JwGFgZj2D6JC85UhuBuo8h5I1HQW4SQUtCd+3AAono/IdfZfSNpbyXgcS0=
X-Received: by 2002:a05:6a21:6d8a:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3c110009b1emr16839341637.11.1784044289427; 
 Tue, 14 Jul 2026 08:51:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d8a:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3c110009b1emr16839303637.11.1784044288972; 
 Tue, 14 Jul 2026 08:51:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm41343581c88.0.2026.07.14.08.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:51:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 1/7] target/hexagon: initialize deferred sreg-write temps to
 current value
Date: Tue, 14 Jul 2026 08:51:20 -0700
Message-Id: <20260714155126.3509544-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfX3sU7TuoLfSE5
 se1wg3L7XpdMlisT3ASqhzVkzZDjTkvIz5N77myUHjQLsyLJMs17DK1qyUpHYNxtc00Gx+qRuPi
 FQpSHkSf7gz5ww70LGWa5FEW9yYN40U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2NCBTYWx0ZWRfXw5sgclBjLW17
 ZuJ6kMKRqU37IKWw1/QTta35z/VtlbNxu1cubAhPdFdxshbe55hi6tNi9rCUwmXXZeYKU82fX4C
 w7CkdorTtsgtmeqAAar8CzZDklAN0jBBVoTD+OQVN6ufuQwhhDujX/LUNkDKFdpbuc4Q5lujz6u
 AFp9tCbke0CbiMIKVoJBR+rcKw4JoDcBTbEZ594wucM2K4ICx5LNpIJGLvholKOHAAhgfD41Qea
 vHrD+wScoK+471vSVsvo3eJ1ZWeLwnii/tWh/8yiAavMcIE255H2FsHtiLxh+q7/qMcVw6ZkBdc
 xr72dem6qTZjxuDRm1kN082WadblO2eAYeSCfakhfTQ71TMajTRT4v8znElndnXihwd47P+QXBF
 CTVdJhoGmWVqfwYqboySTkgGFrhTpL/u2PSmJxu/xbyImqB8KE/pFimqnEoUdU0cqm9nm+cj8Yi
 bvcI+dTZbUjFFDpzXeg==
X-Proofpoint-ORIG-GUID: 2xzp8DkrGq10va4If9j4s4E2r0JkwDhJ
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a565b02 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IlOZXNdbeIrMSDKviAkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 2xzp8DkrGq10va4If9j4s4E2r0JkwDhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140164
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

VW5jb25kaXRpb25hbGx5IGFsbG9jYXRlIGFuZCBpbml0aWFsaXplIHRoZSB0ZW1wIHRvIHRoZSBz
cmVnJ3MgY3VycmVudAp2YWx1ZSBmb3IgZXZlcnkgbG9nZ2VkIHNyZWcgd3JpdGUsIHJhdGhlciB0
aGFuIG9ubHkgYWxsb2NhdGluZwp3aGVuIG5lZWRfY29tbWl0IGlzIHNldCBvciB0aGUgcmVnaXN0
ZXIgaXMgU1NSLgoKV2l0aG91dCB0aGlzLCByZWFkaW5nIGEgZGVmZXJyZWQgc3JlZyB3cml0ZSB3
aXRoaW4gdGhlIHNhbWUgcGFja2V0CmJlZm9yZSBpdCBpcyBjb21taXR0ZWQgY2FuIG9ic2VydmUg
YW4gdW5pbml0aWFsaXplZCB0ZW1wIGluc3RlYWQKb2YgdGhlIHJlZ2lzdGVyJ3MgcHJlLXBhY2tl
dCB2YWx1ZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDUgKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYwppbmRleCA3NzIzNTkxNmY0Yi4uMjhhMTcxYmY2MjMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBA
IC02MTUsOSArNjE1LDEwIEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgfQogICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnNyZWdfbG9nX2lkeDsg
aSsrKSB7CiAgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5zcmVnX2xvZ1tpXTsKLSAgICAgICAg
aWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQgJiYKLSAgICAgICAgICAgIChjdHgtPm5l
ZWRfY29tbWl0IHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSkgeworICAgICAgICBpZiAocmVn
X251bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgewogICAgICAgICAgICAgY3R4LT50X3NyZWdfbmV3
X3ZhbHVlW3JlZ19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgICAgICB0Y2dfZ2VuX21v
dl90bChjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0sCisgICAgICAgICAgICAgICAgICAg
ICAgICAgIGhleF90X3NyZWdbcmVnX251bV0pOwogICAgICAgICB9CiAgICAgfQogICAgIGZvciAo
aSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkrKykgewotLSAKMi4zNC4xCgo=

