Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82148FD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaT-0002Aw-6w; Tue, 10 Mar 2026 23:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaQ-000259-BH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaO-0005lf-7j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B36N7p1573018
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6sQN1OX8itAmeOsMG4EYtU2Hw93wfi1jWSB11v/dd5U=; b=KAA5ts+BCtBdX9Pa
 v51z6Hqa+GrWOXvHaeP8M08rMpRJehWz29yoMXDjspkXtL4dtiT0/hQfbMY9Q9L/
 90ynxQnWgrD2vi57Xaj62gDspd45ruY7g5Oj2dkRkURFP5aiH8Z3nRXsiHOFBIdz
 l1fGm0df3I9ErUzQYd9+SE0Quxq5y9ihMuKHGLrBtYB1YkKpn+T6BbUqi0Ws6nRa
 W+JW6cCdoM8E4hIEpc1vipybAKHYyGsL12mdRHUCWI+PvNGGrUsG5+Ts0F8FlTvq
 IUtT34/b9zSp0ei/P3oocGTSuGyHlu+/vyVS8j2d9xlJ0ua1QwVNbg/2zCoYzxDS
 eIZcyQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9tmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:05 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7400fd1f9so26044059a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773201004; x=1773805804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sQN1OX8itAmeOsMG4EYtU2Hw93wfi1jWSB11v/dd5U=;
 b=DWrooAxoTtC8u+64/uIyG9pwW1Ptr0BfjzrNjcTG1gnnXQE/7xzSpcuf/ilsAd+ilt
 Gj4Npzter2hj0bzWUg9v8eIMvJtIfxt7NoYert3LsEYJiTNmp5rd90mcQ0YdO7hOLEBQ
 QuBu8p0rFAVTEuu6vWQRcbypP/+I+I2gSpZJgaUgmg9DkHCT4ZV4oHPyet/h00ZQ5PHG
 EFIJWRg2O9oiwKtK+763+rWFzSIezokEaDmgnVnMTc7D8GNS/uyMQP3Be1LX4ZMCFdtr
 4+f0EmsG9OQpifrppPrGpfxX6/8o5TfnY0o3Yo173Ui74iMdnh+YJoTHNgZMoPGziRbp
 4Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201004; x=1773805804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6sQN1OX8itAmeOsMG4EYtU2Hw93wfi1jWSB11v/dd5U=;
 b=uWuoRprA6oY59XV0xOsImdqj5at2pIqJ5Vo+uBpKHu53eSyYcTy08I/e9DQ11TeloT
 ifa/lUZf6w5p6ossjGc7MojZ+l4qc5Ko27PDabQ/EImwpIjvOE82bRqN/UHN6GbmhwFw
 93Kf2+INCk1LEnicsAjHmNBh+wT1Aysd38i/yPUp5HMoIV70h5Rx2YKeK/JvQjV2ipbs
 XxcI0lhfLoHY+T/a979QQCVqqzVmsCrsGYdR3WPOnG/X93F1Wvdc/XpqhrHCXLBHzPNM
 VVbl02ljEBaZbu7pVTQJggpsFLwFR0OoXCytb+ISbTIDreoBAKtgg6pa55/OkW8+zf5x
 U8SA==
X-Gm-Message-State: AOJu0YxzW4eoZ/XuyIqC0jIn4MXhd4McOgMa5Y6/hbkYyTWo1UJRWKGu
 QoyfIeAeiTq+ZkE11dJTmYuihf7Dp2/YrLu5Oy0vafOacWumVe5rEM5Drvg938/Di5WBgGLPgX6
 RaDHhcnz7IzROXOgwbQ0JoVeY3HXv2N+GUKcDh3D+CaAn8a+szjQ78mXPxxng+aML+Q==
X-Gm-Gg: ATEYQzx+j+UouX+Ds4EWzblHQXTwD7Ks6yZUsCEEGvLS7EGd0x92ywfMG/Jsu4YZ8mQ
 Q2sIHqhpcH2cZbW4GYiYoXCKBPlIg3AE/H9+XmqY9ZiwZ46c/G59sxTs0KQu5BA5Kjk0uOMnYCB
 c+vR4GSkvh41jpfWXK7DdzBNfWqc4ptg3b95QvNuwiaBpFdD2pky0wLbXMpxzlJHSXFrjPTfXY3
 8+X5SqZyoFH8lU9dhVW1zKIozFjgQiS13r2JkJTkrVJTXFlL40refevrmDhSWllPsrIFBmkHeVb
 BdLn90AnCvYGs8o6aLGfmwRQJUm7sy4X9PjIg+WeoPFIcBUb63f3AzJIxok9Fwb1Ods4dKEvn1Q
 RB5HnUBgXtZz8gQXQcwU8jjvDHEPjKC0tjYjQS4G2r2DUXpew01a61i64mWfxxlFEBswJKg==
X-Received: by 2002:a05:6830:6601:b0:7d7:51af:4aac with SMTP id
 46e09a7af769-7d76a7e8c8amr831036a34.30.1773201004463; 
 Tue, 10 Mar 2026 20:50:04 -0700 (PDT)
X-Received: by 2002:a05:6830:6601:b0:7d7:51af:4aac with SMTP id
 46e09a7af769-7d76a7e8c8amr831011a34.30.1773201003819; 
 Tue, 10 Mar 2026 20:50:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:50:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v5 29/35] target/hexagon: Add sreg_{read,write} helpers
Date: Tue, 10 Mar 2026 20:49:17 -0700
Message-Id: <20260311034923.1044737-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -mcud_D_YCrwGh9EjiTdb9FGWY9-IH5t
X-Proofpoint-ORIG-GUID: -mcud_D_YCrwGh9EjiTdb9FGWY9-IH5t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX0FG08AyyAbM+
 qKxvdcqMkGD3Q1BYKlsj0eApx6dx/IZ0mRipwAZJLWalBeE6DSWLZwtmEe+ASp9LyxLXx4F5In/
 F/P894roeq5lLJy8y3Lr/ERmhJC9UwYlCYAA4Oby1dg4jgDU1q2i6QMvTBpDL1en5CEnEfgjW/0
 uagcw27g+Fb0BRz3UBYMNjsajenJEx5V5s/tvH/3mR6Ogu3p/blWTz5OnlIDz585WKv3zcxgfuY
 d7pZQi2Wsn2lN0insfW1YXAu+OHVAD0o+kuWgyMuG4y5AuWvTrFw6QgSus8SN4Ujtx8lJ62LcCA
 45fzHVftXd9IZSnUBdOPbo5sxDRo3MZauLe2rowcgkUkhsav5JLoqrlQOYPrMBY80xl7/bd7AZL
 pIXfXBKW8UlXpT9zjQPW7jezFUZHLPSoocXcdzLyI4bjYsrzXowwNZyNYtSTMRwjWyWuCi5R1ra
 aGy38Xn7i8FdWqsOh1w==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0e66d cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=awtrkfjtPIBuNREMqawA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpDby1hdXRob3JlZC1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNv
biA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAg
ICAgIHwgIDEgLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNjAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwg
MzAgKysrKysrKysrKysrKysrKystLQogMyBmaWxlcyBjaGFuZ2VkLCA4NyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2NwdV9o
ZWxwZXIuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKaW5kZXggMzhkNjA1YjA2YmEuLmRjM2JkODJiYzA1IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzM5LDcgKzMz
OSw2IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwg
RXJyb3IgKiplcnJwKQogCiAgICAgcWVtdV9pbml0X3ZjcHUoY3MpOwogICAgIGNwdV9yZXNldChj
cyk7Ci0KICAgICBtY2MtPnBhcmVudF9yZWFsaXplKGRldiwgZXJycCk7CiB9CiAKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uYjhlMDYyNWUzZjgK
LS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTAsMCAr
MSw2MCBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMu
IGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNs
dWRlICJjcHUuaCIKKyNpbmNsdWRlICJjcHVfaGVscGVyLmgiCisjaW5jbHVkZSAic3lzdGVtL2Nw
dXMuaCIKKyNpbmNsdWRlICJody9jb3JlL2JvYXJkcy5oIgorI2luY2x1ZGUgImh3L2hleGFnb24v
aGV4YWdvbi5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgorI2luY2x1ZGUgImV4
ZWMvdGFyZ2V0X3BhZ2UuaCIKKyNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKKyNpbmNs
dWRlICJleGVjL2NwdXRsYi5oIgorI2luY2x1ZGUgInFlbXUvbG9nLmgiCisjaW5jbHVkZSAidGNn
L3RjZy1vcC5oIgorI2luY2x1ZGUgImludGVybmFsLmgiCisjaW5jbHVkZSAibWFjcm9zLmgiCisj
aW5jbHVkZSAic3lzX21hY3Jvcy5oIgorI2luY2x1ZGUgImFyY2guaCIKKworCit1aW50MzJfdCBo
ZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1cl9lbnYsIGludCBpbmRl
eCkKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBoZXhhZ29u
X2dldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAqZW52KQoreworICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3VpbnQzMl90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVf
Y291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOworfQorCit1aW50MzJfdCBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhD
UFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQor
Cit2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUg
KmVudiwKKyAgICAgICAgdWludDMyX3QgY3ljbGVzX2hpKQoreworICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7Cit9CisKK3ZvaWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BV
SGV4YWdvblN0YXRlICplbnYsCisgICAgICAgIHVpbnQzMl90IGN5Y2xlc19sbykKK3sKKyAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVf
Y291bnQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQ2NF90IGN5Y2xlcykKK3sKKyAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworfQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBhZjkzYmU3YTIzMi4uMzUx
N2YzNzY4ZmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDUyLDE3ICsxNDUyLDQxIEBAIHZvaWQgSEVM
UEVSKHNldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkLCB1aW50MzJf
dCBpbWFzaykKIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKIHsKLSAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKHJlZyA8IEhFWF9TUkVH
X0dMQl9TVEFSVCkgeworICAgICAgICBlbnYtPnRfc3JlZ1tyZWddID0gdmFsOworICAgIH0gZWxz
ZSB7CisgICAgICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7CisgICAgICAg
IGlmIChjcHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dy
aXRlX21hc2tlZChjcHUtPmdsb2JhbHJlZ3MsIHJlZywgdmFsKTsKKyAgICAgICAgfQorICAgIH0K
K30KKworc3RhdGljIGlubGluZSBRRU1VX0FMV0FZU19JTkxJTkUgdWludDMyX3Qgc3JlZ19yZWFk
KENQVUhleGFnb25TdGF0ZSAqZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydChicWxfbG9j
a2VkKCkpOworICAgIGlmIChyZWcgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAgICAgICAgcmV0
dXJuIGVudi0+dF9zcmVnW3JlZ107CisgICAgfQorICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9h
cmNoY3B1KGVudik7CisgICAgcmV0dXJuIGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFn
b25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCByZWcsIGVudi0+dGhyZWFkSWQpIDog
MDsKIH0KIAogdWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgcmV0dXJuIHNyZWdfcmVhZChlbnYsIHJlZyk7CiB9CiAKIHVpbnQ2
NF90IEhFTFBFUihzcmVnX3JlYWRfcGFpcikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJE
KCk7CisKKyAgICByZXR1cm4gZGVwb3NpdDY0KCh1aW50NjRfdCkgc3JlZ19yZWFkKGVudiwgcmVn
KSwgMzIsIDMyLAorICAgICAgICBzcmVnX3JlYWQoZW52LCByZWcgKyAxKSk7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcp
Ci0tIAoyLjM0LjEKCg==

