Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F79CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3O-0002Va-Gr; Thu, 11 Jun 2026 01:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2q-0001gA-MQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2p-0002hO-38
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GBGe3815511
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5GZH4T2axovWb5Y5+QKnZG26Gi/4A1GoNVSURLdkpAQ=; b=ZXPvg5oH5VVWGp7l
 7WEJsZ3QPyNyKTNpziy0KgVqLnNR6PH3t9b0NiVYTWUuvbNEMcPliOAQ3wP38yX2
 T44VCd2Ay5HxwMm3sC/powk5vgUQQqpCo9IhFW3OB1RklpOOsFlgFvRNCBUee96F
 25wYQN5ff6/VvHo0ml11TLGjoufRWH8pK1l6yK7X5LW9xaGe3t0rtXtCgCXJHu9m
 byiYkubK3zMezI2NdimWOWotarggsdhu6ErQXpbPT+alYt37YiNJJqQm2Fw77LcT
 WfCyC8Q0tbyWSX8kLYICp1OFSTa/NOnifRRsJHEXTNcAM9VWtc5ClCD4rUwzkBQs
 rVbqTw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1s67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ed777a96so450100eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156003; x=1781760803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GZH4T2axovWb5Y5+QKnZG26Gi/4A1GoNVSURLdkpAQ=;
 b=KJlERt1hRaah8siKL00Hd7swVWNNBz393bprLs0+Y3QcEHa66qwjdPp8XJx0aPudL1
 gagyXZs/BCUEoYdzEJF5n02bmO5Ey2rY9wcTAsh0+NfFTgmfaky1wKnLec8l5s5MQ2ck
 e4R09SsG53eyv4yyeKbR9K/7i9Ro17QOFqBR3tRk6QkAwP75eP0/dTvgKH+COzSSWoZu
 hMMBAlmLKFJqBlqN4Bck4E86ncaEyoVgI99G5kL9uyurImcmkZFYy6V0+wvYBDt/AwYK
 rIwSQ9tdqU/ebNevj9PdaBZ0Ab3g/E/G5RPWWsqbzexJVAXrRAMd9FUKuhzOHZuVFui+
 YtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156003; x=1781760803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GZH4T2axovWb5Y5+QKnZG26Gi/4A1GoNVSURLdkpAQ=;
 b=IyLFxIkWtsVs6TIFyTNesNbAroGHUfPoZig6Wr/xK0BwLkjOfjAfuRkWmlbhZkVqMH
 jKr3lW4j8sB5hSjqE2AE6gAimUuozeVQFCSXzGH6RrEi3p/wEVbKYSg0MhlAc8/bInAF
 bmreDjFkBRZBqjjNtKuuhuffKHw3vnlcUr5HH2KfNuRFPW2Pn178XFu9s1KyqKnJ1cQ9
 ahPsrhiZmRb59AX2PheZv567+KVmqjTE/wN7WIkb4RoFXoL6HQEtpMUH5FHNiA9eBPMV
 hxflJ5ELIjxnWFhWEfSQJjM7k7HNVa+ymNxOO2kSCcBhkPeJ5GlZBY5hmQnrxkCkOqdA
 dpKA==
X-Gm-Message-State: AOJu0YwC7E8jAvS3SvVCuRSeQ8H3XQGpHBO8zthCwkpxuTtLbu3tUvAL
 IHzaD86lNNuuWZiwQia96tEBWw47W1uLpWvzK9WWnWVwPYmaGFa0hiY1b/pSWI2PK8sLbWtDbwa
 pZRUKfOYaaQJDdoxL2njjRWUu/z4YdRgr3vYhwTLQQpEj3o5Whj6IMsH1QcoBP2E0Ow==
X-Gm-Gg: Acq92OF3dHju5HcLF8ZsTII2v+xDZ865JdQBeUZY67yC/zm8VsmdGszGanks9tgNRaU
 1ChzZHJ38H9CJE7YydirWJNoUSBUhPdBbSG843MsoE97n/jdBVeOSE/bFYSwaPtFhCSHSPqOc4W
 NSejKoTMWKzch1OpnErH+yKz7IS0rFzAt3zt+aqWueF2/zaZ18TioayDhFZJlzyyrvhO87A7tKC
 F8atHayigsfLP8F/F7mt4DM8Ir1XN/pmf92T8bI9MRx+wymI0iZaeu79zaWscL9YFNWeUyaKpHV
 ehMrl9RuReUVZ/8M8RL1Y4M4r8Kt1k9u7TBSqoJeJZCW0REk3eSHfr6PV+fKZ2kK8+UTGQN+6dq
 rDfP6XAYdLF+unsLIfYfOUkMJoJ+A7kim4I8o7pwXOTa3SHTWP+zhL5ZqzuW2d+c+byGV5zeB9I
 KxvIMi
X-Received: by 2002:a05:693c:2c88:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-30805da6511mr824455eec.1.1781156003077; 
 Wed, 10 Jun 2026 22:33:23 -0700 (PDT)
X-Received: by 2002:a05:693c:2c88:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-30805da6511mr824437eec.1.1781156002572; 
 Wed, 10 Jun 2026 22:33:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Decode trap1, rte as COF
Date: Wed, 10 Jun 2026 22:32:39 -0700
Message-Id: <20260611053249.3918491-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: EaaoR_kFxc4Q6SExH0rRa83UpKoMpB0N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX/EurYQI02eVy
 mfR06UPwdVdXaHRnRWA+/z9QhW9YzkaZCw9X0FfwPXqyAlOf1gD7pjlorFXf7dGxVRsrfBSWpjm
 oGAcCVjnGgln+Kkp8KaNymGkaVE0sfU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX+1ks3VTlpjzY
 aRJfUZsMdvQP/MrtMLVIc159FgwxH0z+gqoYIWtoF95oCl1i7npJsx/2uAYIynbwVErmnqBWk2p
 mog1ApmRyVgxnEyFSm7D0wj39FGmYHKOHcSEZ50n4zdOqwtnVGhqk8Zb1Y7TAqXWN1oYkE0UfVc
 Oqy31oHmwqhPrXrOZpou7kEidjCdEjNmWSrxmqEAl3ji5zfuR/t46EG2EqQm2WBgm+qiG0I5fml
 MGhaqChCqltN1bNpAE6mDb1ZVXofJVsru0+CL/Li7OECn7wknfMgclj5rQq1Fv9Q2qO+lfqaEgd
 e1ppuxG8FGJDqZdRG+CsmnOWhQUozKKjpRxghUjEBEAgYwnIqN7c0Gk35i3CXD7CG4mqyru6zug
 8AY61MAVC7marAFu+HNAS0XcWlGLfvdNrqQ4NKpoig0y11HVC/CedAB59kMM8ysPoTm1KhA4RRH
 spgPGz+tNNIl4GJkkfg==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a48a3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EaaoR_kFxc4Q6SExH0rRa83UpKoMpB0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgoKUmV2aWV3ZWQtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9k
ZWNvZGUuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFn
b24vZGVjb2RlLmMKaW5kZXggMTU5NTQ1MThiODMuLjZlZGRjY2EyNmVkIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAt
MTg1LDYgKzE4NSw4IEBAIHN0YXRpYyBib29sIGRlY29kZV9vcGNvZGVfY2FuX2p1bXAoaW50IG9w
Y29kZSkKICAgICBpZiAoKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0pVTVApKSB8fAogICAgICAgICAo
R0VUX0FUVFJJQihvcGNvZGUsIEFfQ0FMTCkpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfdHJh
cDApIHx8CisgICAgICAgIChvcGNvZGUgPT0gSjJfdHJhcDEpIHx8CisgICAgICAgIChvcGNvZGUg
PT0gSjJfcnRlKSB8fAogICAgICAgICAob3Bjb2RlID09IEoyX3BhdXNlKSkgewogICAgICAgICAv
KiBFeGNlcHRpb24gdG8gQV9KVU1QIGF0dHJpYnV0ZSAqLwogICAgICAgICBpZiAob3Bjb2RlID09
IEo0X2hpbnRqdW1wcikgewpAQCAtMzYzLDYgKzM2NSwxOCBAQCBzdGF0aWMgdm9pZCBkZWNvZGVf
c2h1ZmZsZV9mb3JfZXhlY3V0aW9uKFBhY2tldCAqcGFja2V0KQogICAgICAgICAgICAgYnJlYWs7
CiAgICAgICAgIH0KICAgICB9CisgICAgLyoKKyAgICAgKiBBbmQgYXQgdGhlIHZlcnkgdmVyeSB2
ZXJ5IGVuZCwgbW92ZSBhbnkgUlRFJ3MsIHNpbmNlIHRoZXkgdXBkYXRlCisgICAgICogdXNlci9z
dXBlcnZpc29yIG1vZGUuCisgICAgICovCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkK
KyAgICBmb3IgKGkgPSAwOyBpIDwgbGFzdF9pbnNuOyBpKyspIHsKKyAgICAgICAgaWYgKHBhY2tl
dC0+aW5zbltpXS5vcGNvZGUgPT0gSjJfcnRlKSB7CisgICAgICAgICAgICBkZWNvZGVfc2VuZF9p
bnNuX3RvKHBhY2tldCwgaSwgbGFzdF9pbnNuKTsKKyAgICAgICAgICAgIGJyZWFrOworICAgICAg
ICB9CisgICAgfQorI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkCi0tIAoyLjM0LjEKCg==

