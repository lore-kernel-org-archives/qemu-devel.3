Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94AFFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zp-0006mO-9F; Fri, 27 Feb 2026 15:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zn-0006lQ-G7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zm-0006ng-37
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:43 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0HPu3944632
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fAcYWPNnMw3SI5yftuBtoBojs6xkQ5SwYGBh8nP3FXU=; b=PaR6Iu4JS0v/BUJr
 5PR1TgIIoRXqMgihvk7s73BdcIJufHRYe5kg1quxl4x7BCvCcObRF5vwYnamAe2F
 qwdm3cibUderRKv5MfjCicAPlczgkUfWjg421PF4dhYzXpEqRxQC8e3Ts97CZHq4
 856tF8hwukynrCa0QrKYJ78romLZED/8+LE7zJXKM071PvpJqdrMTf6RHeYQg+pI
 O2dxzcRIb51zt2RxZXGg5XYzqrlrCN7nsGxknEZqYrTXShutdY0X47xn/jpKVbUa
 WQmopZKaJ46f9QvHPQjSfUu4q4kON7IjG3lJW4X15D8dXLBi2gCpb3vsndFfJ55M
 Vyb7TQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q2d5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:40 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d498212845so14402802a34.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224599; x=1772829399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAcYWPNnMw3SI5yftuBtoBojs6xkQ5SwYGBh8nP3FXU=;
 b=KY9ZM6hs1AbQWzt/KIHh4sivfliwrJadgee7Dsj7+Zpqd87++MQ7mc5M9QNDAjUZ8f
 sLldjSTENrD0/4B9xoXDyIFeeyDFHaLP5KT1EDs04fhujyB6EETo+RbsWUoobTkhqKLn
 LLzeRsRqcNX2czHaVUGI8xuDNJFVP7fGiKCKYamB71yQ/XrjLVMw3DbXNjKr/KyVuqfL
 pp2SxDgwVkqOVPuyPeIHtRpsvdL4n9so1vNytTvmDsRiKlHOY4+GK4GLl9pTaW3H2ccF
 x2u2jZXe/HVowWR0ZM7jFTinORALgcNOoGH/kzHtx1eEfjHGI22KnRAwXeTdi34yQo9c
 9O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224599; x=1772829399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fAcYWPNnMw3SI5yftuBtoBojs6xkQ5SwYGBh8nP3FXU=;
 b=SawYWXbdHtROlPEuP31Qc8sxGrGNKWRGdRnCG5uEhAn/IalXarHVN7XnwwUz6+xnH1
 4jUELJNjdh4JRS9lbjPMA/TFqP74BBwMffhaGfcVAT5hcT11Dl1hEwu+ykM+bwOs8F0Q
 MGV19jAlxkjQkODf8mlYJrsNRhhvHpvBoE18xD/+GNtXkw8BaVEpZN1t7vuu6Umma+Jp
 yU90rHW0u4QGE3S1if/jt3R1bvDARcCPmMkD8FMNl9oLY8TuyAWYN0/2wAH3lfDUbsOX
 1dF5QnptMLZlBajy5sy3btIIsvaN06mcyT0PsvYRyDHpoMMxzMUcuGg3QJAR+ErI4fp/
 Km8g==
X-Gm-Message-State: AOJu0Yy2iTVvThXRgV6/QZE1G3kpx/z5sbwa+UgDi+4o4/V2YtJKKqn1
 y8JVYzIBNtGHGlLxKGl0o6yWuvteAA9rSU+TZGjOsg1cd9wZxH66PNa/aSEO+XtkXwo3uwUxHbx
 17ZsRm7zRqFl917weHdsE6/y8GBecjUb7RyrWIjQhfTXFML3F5jnovR+upVwPjq+XYA==
X-Gm-Gg: ATEYQzyxhiK1hBZoKqHONFf8+9Q+hPCjdE6MfjvfkulFojSsFTQTryk4TbvFIBSYVJU
 MfdQDn5f93YTQPNKQgk0vxxz6sDdqnO78rYUdZ+ERoUgXBqS2VJ5xNhmn1u/DOqYfZlNaJadL3x
 MEAtVM5U+F0iUt+o//t0fzLp4IVqrueMbSRXSLdK08rUX0Kt8BgNJqPK5c2MVB10bs/N8OM/o/G
 AsE3EvSC2eMlKYsnhwbqlSW63BAeVafTulwOVqAvE7NcRH5e73yHLG7UFl36A7TkHwd8WfcUZkD
 pL92qL+voL1Pc5PfIPAmRqrPQDnihk5G4crsp6yMH38faRubMYB8ZtcayBaw+iKbEssqBtcQtGv
 S/dxwAarvqwcFnLtuJr2wx6dnMOE76gMezr+NfXRpcY4oTd/hIJcPNrULTJT6RGvX8Xhm3w==
X-Received: by 2002:a05:687c:40a1:b0:40e:1eb5:73e1 with SMTP id
 586e51a60fabf-41627093a33mr2811025fac.44.1772224598814; 
 Fri, 27 Feb 2026 12:36:38 -0800 (PST)
X-Received: by 2002:a05:687c:40a1:b0:40e:1eb5:73e1 with SMTP id
 586e51a60fabf-41627093a33mr2811002fac.44.1772224598282; 
 Fri, 27 Feb 2026 12:36:38 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:37 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 03/37] target/hexagon: Fix badva reference, delete CAUSE
Date: Fri, 27 Feb 2026 12:35:53 -0800
Message-Id: <20260227203627.932864-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX3GcO05LGqgw7
 LyNypIRAkx9498dxDwWlDGVoKDVwSBfi7HdLizBznXVuqK2tOAD7Ei/I9nM9zNsEbTqBSFbB5Yr
 I7F10qpBjOa7akkbLv+0cHtr+NDpXq5Gmfai1JM8GOlDZkh0fxAa0caR0dYm8+ax92TFUNiim0q
 lOWrUv9kdHKQN8O2J5PE6jMf1xM69l7vKYI/TRgTN4jAj3ZcDXh3GyT561W0vtjMDSIml8W4smx
 StqOvEoJmRnI2aNfhFkWdbL3IuT3XULroK6pkbeniycKVr+o3Zy3ayoeJTZcZXWBldPDt7ob0ZL
 D0oRT3RM8e91J9MvkCjucN6zx7xs2zL2pihHaq/aWqKuNw9hlAmsF+/DA/ignPBb5VkSY9CpCb3
 M7WH+PEX7Kwn6IYv37o5t8zjxJi7oAAak678/1sNGZeNbUm/9UE03AFEbv0VKQZUcQZ7/Eh0VT4
 +TgTuwhdQ9++OC+iC+Q==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a20058 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=OkFKjDXjCESYpyaXCIMA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ji2_mjD9aGNyg4hbqBCAMAhvRQabbd5I
X-Proofpoint-GUID: ji2_mjD9aGNyg4hbqBCAMAhvRQabbd5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgfCAxMSArKysrKysrKyst
LQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4
IDU4YTIyZWU0MWYyLi44MmM3MjYxMzlmNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTExNyw2ICsxMTcsMTQgQEAgc3RhdGlj
IHZvaWQgcHJpbnRfcmVnKEZJTEUgKmYsIENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVt
KQogICAgICAgICAgICAgICAgICBoZXhhZ29uX3JlZ25hbWVzW3JlZ251bV0sIHZhbHVlKTsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgdm9pZCBwcmludF9zcmVnKEZJTEUg
KmYsIENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtKQoreworICAgIHFlbXVfZnByaW50
ZihmLCAiICAlcyA9IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAgICAgIGhl
eGFnb25fc3JlZ25hbWVzW3JlZ251bV0sIGVudi0+dF9zcmVnW3JlZ251bV0pOworfQorI2VuZGlm
CisKIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRlICplbnYs
IGludCByZWdudW0sCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2tpcF9pZl96ZXJvKQog
ewpAQCAtMjE2LDggKzIyNCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fZHVtcChDUFVIZXhhZ29u
U3RhdGUgKmVudiwgRklMRSAqZiwgaW50IGZsYWdzKQogICAgIHFlbXVfZnByaW50ZihmLCAiICBj
czAgPSAweDAwMDAwMDAwXG4iKTsKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MxID0gMHgwMDAw
MDAwMFxuIik7CiAjZWxzZQotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ0FVU0UpOwot
ICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQkFEVkEpOworICAgIHByaW50X3NyZWcoZiwg
ZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzAp
OwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ1MxKTsKICNlbmRpZgotLSAKMi4zNC4x
Cgo=

