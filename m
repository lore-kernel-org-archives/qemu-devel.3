Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF96C55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphu-0002ta-9H; Thu, 06 Aug 2026 00:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpho-0002rn-3x
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphm-0003De-Fu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763x8xX1071632
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=x33rKD5AJt14CHYPvmx76d8qJqPC6RXtU8ksUlr6PXc=; b=ky
 E94WLl8Eqf2TAYZL/6dcE6ZrIxgJKDZ3DOqtcqtLyDCho/4YK+tH4WLQkFbHuqzH
 h7DjH3F7E5ed6tpfsp02xJostulmi+hJUPpM4+0V4Z9SBPMZZz+ybgpFXXT4/hrG
 BfJfdMz5SdVKVaKaueSlVYtaSm/nIx1+n628nLr77ZuW1vCEveLxAGYxPITRS/sN
 kXGN8fo+p1E0Qkv/MV7lp2D3KVpvtrtfdudANrHTAfLoj5dqMPWIIXeHjcN2w/bR
 xzODrD19g88XG4Cjs5v25Idy8jVOybdf3nTjyIdH8R33PuWPX9vWt183M9W85lZD
 kbcePYBKdUfgroIUM4aQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjucg372-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:41 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb5bdd8450dso1147767a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990460; x=1786595260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x33rKD5AJt14CHYPvmx76d8qJqPC6RXtU8ksUlr6PXc=;
 b=Q6XaFBy1qAxVhIbvaUuf6ROilX45lx/NKVrAJaNJuM5V/d7CUq6wV/uWoT50oQL5Wk
 mAOPYs6PrrHLp4MvhY2oXtlzsc1ZqFe2LFzaDV6b1+PV7ShhNNESClWRcEPIIyG2UBwm
 p3IFOd5ZQD8EAMRvnWQ9lc/m2cAEJ4/dMgQP7RaHlFEW6P+zxOMSFs4OvwJwLp2LTN3r
 pMhMjdnAjv7HWqA4dLBdfSkyLuF4sYuRi2cGN6/NEKcj5p1oanYHVgM6Q98jPHO1Veb6
 vChlQnXIfs2dfUpylYonsMiPbV+wI49nGh32wqnmcUIjXvQMsWMMdnX9t2qlmRfgQHAt
 EeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990460; x=1786595260;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x33rKD5AJt14CHYPvmx76d8qJqPC6RXtU8ksUlr6PXc=;
 b=MK9N7bbnRir3u7md1Hwld5A1TQcHlldq7sC4GtMKxtQrE39vOLsUavQtFZJVY5l9mK
 3Nhs4iIGu5n5ypeIDJ/jeg053/9/2CHgypo+z+qjkrZ6IQs2bMaqgNcyAofytCmNWfzV
 kBz8URG4jzXk4KF5ac1qh+8EbBVWmQHMIG2nD1f1TpBGCDuWMAgrtHoSOoYB0mvuL8nl
 Vw++0ecWcznyqRdnBZGdkg92Nxi2mJUWWXy6qw1YQ5hPmCxFYu54iBJs9fUbEMKV99qc
 CgjAgLQvwS1AmdG1sDfRM/eyXNsxdA4mbdUl8fiJHs7F4PQNH/+w/J3YotSRR4BFDtXF
 2CGg==
X-Gm-Message-State: AOJu0YxdcTFO1dKOQEuxRuLIC782FmdcpxS1GLHGKzjT2nyGq3pkCQOO
 bd3weoQsmJGtn/RYEVSouBc+bgDTn2byTFpEg8Yl8iikyWXXErNfML3b+G9Zi7Alp+ze+U6b3hM
 HfNcHOnJZGalvR4s5eHARBjD5iBn6TY+iIQwS+wVlePYzcHQ9jzcRsUSxc/EMEJ2zag==
X-Gm-Gg: AR+sD13tr0ARkE2nrip9QAV02mPxGn1JAMEXQY/ETTDNnSLn8cyEGhEo2fL4WeeOyMG
 tUARnvmIqpKLQPh0Ia+fG0wlngZ/ZPiWMjqoNLI5b2qzEOHR/jtV8Kt4iJsKvbCWOTd1bc+9Lt1
 W4AO4T90QLIwc1qLHsy7gaagk5xI5JmZyzxhn2dnoi3b1lH1xT6ucmFPHx5Z3Lk7i3gRrbexkb+
 vcIXJsDI2BtaZxBpR4xL7hNY+r6QaGenXRzCoXUZspYbcUcI4tuBUCDhthta14kPhfwBF1c26yM
 Us2l9oL2Fxg+/o7wgt/4cBYhr5aqVJBMJ3sOwy0FP6TPtKdkL5bQFXyU65+VtTJFu7+fTootmUr
 zkJPvrElRQdnyg0laWwPFagfxitq4aOIZEdFbI23wyUd58+xU
X-Received: by 2002:a05:6a20:4309:b0:3c3:7481:7a03 with SMTP id
 adf61e73a8af0-3cb86028b7dmr12701318637.34.1785990460322; 
 Wed, 05 Aug 2026 21:27:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:4309:b0:3c3:7481:7a03 with SMTP id
 adf61e73a8af0-3cb86028b7dmr12701265637.34.1785990459923; 
 Wed, 05 Aug 2026 21:27:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 10/18] hw/hexagon/virt: instantiate virtio-mmio transports
Date: Wed,  5 Aug 2026 21:27:15 -0700
Message-Id: <20260806042723.3785369-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX0ENinrb+R2FT
 Jw050jzt9RBpvQ8MZtttPNEUIddrRqMqClz3Sh0EXzzY70oqJZctgkRuYQYmSOObam7Jx3dhUdc
 TvEoV91y/tB8YxIkgwsiU/v6fSVtCu0=
X-Proofpoint-GUID: 4LXixnNLICtMvZRqrmwKM3aEBO2EzA9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX/MknICycPU0d
 NYwQcN0Afu8FrYChrG3vQ7a80uzmEJ8oKvCa0rz3re5HebgnSMt7p5pC45xtUJC9v3gh6n/K/LC
 7enB8SGxgXdQge8Ak4fUUNv7+8Tyc5aXRGZVsagQr7jS/2xCgEvoCEPgEItohZATOrLVoad2Lxj
 EaZlf0HuEZUqccYmS37vVJF9zb+o3eemXsc1qxjOw39wfXprdZ7IbwQiTPhhB6yZBoYJx11A7vg
 YBDfNuRWDZSmWy2Aq64sXgHyPqmineh3azYF+HX1gaHRh5a61xlT6xelgHZK8zt+RvMtSAKpiHv
 ieuVz4JRmU2oHZjjQ3SANa4070e5zQyYieb/dxA1mFne+SwkPmFje8tg5/2fs3T5A92/NYkFre9
 PV5yvZdBf05kaIojam+MHXkwK7rLlng3O4zUh4akAM52nIMbMAkGs2YF4XCMMoJi6cpJMoDjA9j
 t1vuFEV2mYGPm5Cxt2g==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a740d3d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=qfYuoNLC281KTBfHwCsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 4LXixnNLICtMvZRqrmwKM3aEBO2EzA9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060030
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

QWRkIGEgVklSVF9NTUlPIHJlZ2lvbiBhbmQgdmlydGlvLW1taW8gdHJhbnNwb3J0cywgd2lyZWQg
aW50byBsMnZpYy4KClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vdmlydC5oIHwgIDMgKysr
CiBody9oZXhhZ29uL3ZpcnQuYyAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9oZXhhZ29uL3ZpcnQuaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKaW5kZXgg
Y2YwY2QyZjhmMjIuLjRjYTJmMWVmODU5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2hleGFnb24v
dmlydC5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi92aXJ0LmgKQEAgLTExLDYgKzExLDggQEAK
ICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb24uaCIKICNpbmNsdWRlICJ0YXJnZXQvaGV4YWdv
bi9jcHUuaCIKIAorI2RlZmluZSBWSVJUSU9fREVWX0NPVU5UIDgKKwogc3RydWN0IEhleGFnb25W
aXJ0TWFjaGluZVN0YXRlIHsKICAgICBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlIHBhcmVudF9v
Ymo7CiAKQEAgLTE5LDYgKzIxLDcgQEAgc3RydWN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlIHsK
ICAgICBNZW1vcnlSZWdpb24gdGNtOwogICAgIE1lbW9yeVJlZ2lvbiBiaW9zOwogICAgIENsb2Nr
ICphcGJfY2xrOworICAgIERldmljZVN0YXRlICp2aXJ0aW9fbW1pb1tWSVJUSU9fREVWX0NPVU5U
XTsKIH07CiAKIHZvaWQgaGV4YWdvbl9sb2FkX2ZkdChjb25zdCBzdHJ1Y3QgSGV4YWdvblZpcnRN
YWNoaW5lU3RhdGUgKnZtcyk7CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL3ZpcnQuYyBiL2h3L2hl
eGFnb24vdmlydC5jCmluZGV4IDlhNjgwODUyYzNjLi5mZjA3NzBjZmM0NiAxMDA2NDQKLS0tIGEv
aHcvaGV4YWdvbi92aXJ0LmMKKysrIGIvaHcvaGV4YWdvbi92aXJ0LmMKQEAgLTMwLDExICszMCwx
OSBAQAogCiBlbnVtIHsKICAgICBWSVJUX1VBUlQwLAorICAgIFZJUlRfTU1JTywKICAgICBWSVJU
X0ZEVCwKIH07CiAKKy8qCisgKiBWaXJ0aW8gSVJRcyBydW4gZnJvbSBWSVJUSU9fSVJRX0JBU0Ug
dG8KKyAqIFZJUlRJT19JUlFfQkFTRSArIFZJUlRJT19ERVZfQ09VTlQgLSAxCisgKi8KK3N0YXRp
YyBjb25zdCBpbnQgVklSVElPX0lSUV9CQVNFID0gMTY7CisKIHN0YXRpYyBjb25zdCBNZW1NYXBF
bnRyeSBiYXNlX21lbW1hcFtdID0gewogICAgIFtWSVJUX1VBUlQwXSA9IHsgMHgxMDAwMDAwMCwg
MHgwMDAwMDIwMCB9LAorICAgIFtWSVJUX01NSU9dID0geyAweDExMDAwMDAwLCAweDAwMDAxMDAw
IH0sCiAgICAgW1ZJUlRfRkRUXSA9IHsgMHg5OTgwMDAwMCwgMHgwMDQwMDAwMCB9LAogfTsKIApA
QCAtMTY3LDcgKzE3NSwyNSBAQCBzdGF0aWMgdm9pZCBmZHRfYWRkX2NwdV9ub2Rlcyhjb25zdCBI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogICAgIH0KIH0KIAorc3RhdGljIHZvaWQgY3Jl
YXRlX3ZpcnRpb19kZXZpY2VzKEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCit7CisgICAg
aHdhZGRyIHNpemUgPSBiYXNlX21lbW1hcFtWSVJUX01NSU9dLnNpemU7CiAKKyAgICBmb3IgKGlu
dCBpID0gMDsgaSA8IFZJUlRJT19ERVZfQ09VTlQ7IGkrKykgeworICAgICAgICBpbnQgaXJxID0g
VklSVElPX0lSUV9CQVNFICsgaTsKKyAgICAgICAgaHdhZGRyIGJhc2UgPSBiYXNlX21lbW1hcFtW
SVJUX01NSU9dLmJhc2UgKyBpICogc2l6ZTsKKyAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9IHFk
ZXZfbmV3KCJ2aXJ0aW8tbW1pbyIpOworICAgICAgICBTeXNCdXNEZXZpY2UgKnMgPSBTWVNfQlVT
X0RFVklDRShkZXYpOworCisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNU
KE1BQ0hJTkUodm1zKSksICJ2aXJ0aW8tbW1pb1sqXSIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgT0JKRUNUKGRldikpOworICAgICAgICBzeXNidXNfcmVhbGl6ZV9hbmRfdW5y
ZWYocywgJmVycm9yX2ZhdGFsKTsKKyAgICAgICAgc3lzYnVzX21taW9fbWFwKHMsIDAsIGJhc2Up
OworICAgICAgICBzeXNidXNfY29ubmVjdF9pcnEocywgMCwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHFkZXZfZ2V0X2dwaW9faW4odm1zLT5wYXJlbnRfb2JqLmwydmljLCBpcnEpKTsKKyAg
ICAgICAgdm1zLT52aXJ0aW9fbW1pb1tpXSA9IGRldjsKKyAgICB9Cit9CiAKIHZvaWQgaGV4YWdv
bl9sb2FkX2ZkdChjb25zdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQogewpAQCAtMjQ2
LDYgKzI3Miw4IEBAIHN0YXRpYyB2b2lkIHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1zKQogCiAg
ICAgZmR0X2FkZF9odngodm1zLCBtX2NmZyk7CiAKKyAgICBjcmVhdGVfdmlydGlvX2RldmljZXMo
dm1zKTsKKwogICAgIGdfYXV0b2ZyZWUgSGV4YWdvbkNQVSAqKmNwdXMgPSBnX25ldyhIZXhhZ29u
Q1BVICosIG1zLT5zbXAuY3B1cyk7CiAKICAgICBmb3IgKGludCBpID0gMDsgaSA8IG1zLT5zbXAu
Y3B1czsgaSsrKSB7Ci0tIAoyLjM0LjEKCg==

