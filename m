Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428AFCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5De-0003VN-C9; Fri, 29 May 2026 17:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dc-0003Go-4L
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5DZ-0000q4-8q
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIeP6Z204240
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7jxkk2sWTnge936nkYK0El/Q5cgEUJH6TW4dEtKN/20=; b=Ig8Oa2A1zZKFMMnB
 jV2K7NGN4l4LGoIPwxCk1Y712GfG1Tc/orvUZj4mwQeD6zbta899x8/L5n0mFvHR
 BCPlqLjUPknau5g0ijQJWQADeOisRH4zLhWvjsurZbUI/sx6C23H7F/IrIfKUHf1
 G+OWWUDfdVW9KcD9vw986X+KCbtDblqc4y28yBhsMtPp3dYkPjPY3bw2IbdgatTr
 YZKttuY82EzbcvkjrhY/Jk6aPRM0zq/SgJIms+lnBbGIsA1/1fE01FgTLOLhn/yX
 3+Qnj7GJShEGb9kCAbDaFOffDXeBFsNApSmROfyyAIgeVfsNK/h8+sinlCUePPFB
 x4fuhw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8r4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so2001291eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091891; x=1780696691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jxkk2sWTnge936nkYK0El/Q5cgEUJH6TW4dEtKN/20=;
 b=j8D1lOZvBW9aQWeaWVAmn7fUV9KK0KR5txCSuM5h5ANA3hORHFX6V32tji77S+uJVT
 Z0Wz2gBG9MCvjBNAu/tcudtB5w2KtOpaTU+QgB/J1Nu8EJLUqdcvi7S5UQZbC925j+D+
 7FvPkvfjqeoFFvXdF+vgS85VHA31eODKx2FsjK3eEn+j9K8ocRVcb6EN8bLmUlGNGrsr
 oaxt4R013PV1gCAmsatzOkWFzzKzWKoHRyMKlB8VHzXgskOk9HHi3l11S41lRwud60wM
 k0flTaK6ILgd7WGz1mFMFKHSvx3RrB+IawCS98Ucdg1d4VZE6lXKAEZNJXPBrFcVI/o7
 3x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091891; x=1780696691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7jxkk2sWTnge936nkYK0El/Q5cgEUJH6TW4dEtKN/20=;
 b=QKIT22Ce2WsJSogrw0kuGctoQL/ylSdLP4eWn7ZUp9szYheeowJojFme3LE7BcALfD
 OFDQkMR5rd1qOCDKAWfs17tCOxNGvj6mpQiOBndECXx2natYMfToZD0uYdxi6ppi1fuk
 gT+/vWGThkPvuUBmBXw7VOdK4fexzoANi2GXDLbcogeWZlWZHhue978nWjCHtKCYxJYt
 vt/CjcVWKV/GNjl3xqEyl9SO4Yy9bYxIpKWyPA0OFIM+bldvUwmzI75C/4kd+jj5u/aJ
 EpHeibzUArnzj2etV/4mayaxSyFnxaCOrewvqZumZOk8w0mDQ3baX6NKcLnH9RE2oDXk
 Dwog==
X-Gm-Message-State: AOJu0YwnIgQWB9xiDrF5dc7ZmTE+T11nBPoRHeyIorFsfYyjEkIK/iez
 jimdLNqZYIMsgtlC94SLYlfpQ5M6cDEoE3G8XTL5nV0Yh/9ZgL3NGqQUT7yTao2h1lkdwkW18aH
 q9GSUjb607RXdb8X8pDLhAUfHvxpfC+WFTocmFhcfQ64JsawxdPMMjjUQg9c5F6cDSg==
X-Gm-Gg: Acq92OEw/O5t/YsDOzUdjKzu/RgHrHSfNBGW0XmVncWwlAFrbVjndChnOfxzW2jC530
 JQe/1UIKw2eQyOFZW3cditIqk8pCfr5dVNjelGPaVLjXfAqzd3oA1u4gwN87UKpfrhdQGpwBUx2
 WgYC+mgb3M/wtoFtZ2SJfzlT5BHS1K2s1zhYg3u5glXEfb06RtCYbCm3expIlKgtdMiJiowxtla
 YOMM6w5lxbzlENbClebNWK3F8DeKFYjYZFbDV00KNE1zwr/U8IBdueavngfEAq+Wlx2gXZrlGfm
 OJPtDm7MFGO4mHblQGovd+CivSto8LCwZwY/p+qZ3ne1s8cLP0KxunfLbLwUivl4CNFPxSLfqAv
 BQaPKHz7pKDXp8IT3OsoyoTov2/hdOpTE90GMkrzz+wRwHibovAXarevE2jpqATSvnWI5eJWMyU
 oRrGJx
X-Received: by 2002:a05:7300:6427:b0:2ed:e12:376d with SMTP id
 5a478bee46e88-304fa6dcc72mr840580eec.35.1780091891287; 
 Fri, 29 May 2026 14:58:11 -0700 (PDT)
X-Received: by 2002:a05:7300:6427:b0:2ed:e12:376d with SMTP id
 5a478bee46e88-304fa6dcc72mr840565eec.35.1780091890739; 
 Fri, 29 May 2026 14:58:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 01/28] target/hexagon: Implement {c,}swi helpers
Date: Fri, 29 May 2026 14:57:39 -0700
Message-Id: <20260529215806.608770-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4eKHaRVNwGAB
 uHfpy5JTVVcM9cUnZW/CrgTx8KqWzWlohRljJYobMTJEqDR1mgtqEcAkK066IVYvCiBrAraVLaT
 6M0bs3xoV2MrmqwcHUum5o8iSHOVJX4X89R2xmFhRNzUB2K2CqF1znlm9qj8pVyUNVi+SwBVfs3
 6Dnxd2Kq8KYUkPYnuCjLpPrtwk5MG0AzLMwjYGKdjkH3S7xT4lhg2nk6DanfpJ6cldsDhl1dC3Q
 lQvr5JIVrk7iWleK0HZbERuE+4Xhe8HfqxLljcCH54G9YxK3LmL48FwONBwjAt0rL4IyVChzGNp
 enoxPk0uDaiWueYQYMb9xlLRnHjuPlIkkDthEV2m3BQl8S40Se5OrVH6XHCq8QrNHgggC4oY4e5
 6bxZZBovG3LpU12TyfwxBHeXRlYgRRjn1FnQXwnJyAV4qhTjNpfBrvuP9VIK8aQF9PSY8XJETnL
 4TQ/dNQMLED1hIRFlNw==
X-Proofpoint-ORIG-GUID: AnomMNlE_TnQwFbkWHtoRXxr9bnyFmAD
X-Proofpoint-GUID: AnomMNlE_TnQwFbkWHtoRXxr9bnyFmAD
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0bf4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
OTQ3OTg4ZDI0NTYuLjA0ZDlmMTI4NmM5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjMsNiArMjMsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzUsNiArMzYsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MiwxMiArMTQwNCwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

