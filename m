Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2B9CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5ET-0006FV-Qu; Fri, 29 May 2026 17:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EB-0005vJ-Jm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E9-0000wh-SC
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TJZtNw4123960
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=; b=EKM0CGHDYMKAFMbd
 x9hs+tRaldkLcAt8cz4BKozGSWEw7m6M4bJaC1B+rokfrShEcfdYhG7oEAMRJZyn
 92Fh7IAOM7p4Ec1IAfmDAWbfwirIE+Sh3x91OOVyS/GAFlTwUyZbmXjNa25AzChh
 QRF1WOgqcNFllFOF48ZA9wKX3lgwvZuCERfsE+ceF+d6RFhxhtq6/Ty5dGTlfrFJ
 4vawvgmkQBhBNNLfNAvSLFQYg6UuvKJLGFP+te03rfoBC6aKabTs5qyXtdB/jq5Z
 rMD3882Bv5zzPkZu65PLAL4eAQ4Q0cCaKsX/aHaGlmJGkUvAPG3o8U9l+zXG8rJ1
 gQ8hVA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efh3n8g3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ec73b015so971235eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091918; x=1780696718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=Wjf5opha0BR9HO+4kW0qMYui4Yx94kHKNo1g17Ae5qqn0QjtS6m0QyURsDmoO1mx6R
 fDozQpWkfNbuIMt+QN1mJ/+koJB0nG99wY6zqmYEErjOagEAJBt3RY+N8/RvSHORpdnI
 0cTZlae1ILYpf2sp6n+4ytKRPDbF2j8st6+H/UDwgT5T/VpX4l+WlEUFdVL++0GuzL7s
 djR6ISPzfbsdX2IhKlpN7znWBlGSNgbZfmuD3ew6NEwYSgLHRYQIfDA4OlF9PzWsV76q
 wwmr535UBRejCUuIjzAdS+1bxIjbfbsFzs3S0mIHZTDFDKZzUnxwWZqP/o/h3Q16G6uQ
 +y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091918; x=1780696718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwmtLwNQ586yD7zGJVwVTp7uqi8JKqPltGIMKxadn6Y=;
 b=jiW4IWyEOIFimSJPXuleW6BQ7nLgWzvza5vC8eN/zgR7+hkB81JYKqUmOZanOvWEFi
 n9+KzjgBr2gt69TarnP1HrytRwrVV/SE15ZtOX2bTdEbJj+cOmoPTbDRXJU8mN6cD950
 gNCLcgqlt+8VVLF7v7gPBq+17QYHIiJ86I3LIiuz5yKtCP791PXcJF0gn+HMmUK+JGCk
 rM11KYtqHVCJd/NUBg/mr3zdsBs88L5LDH0qkJygriaPGVC0aCYGV+CJW48ZCGhx+h4t
 SHIHHaMwgfhGzERXKShZx4RrhH/vh3Gx59DqnIyleqvnDMfYuv5g/ZWLNLY9m3sHmW51
 pPRA==
X-Gm-Message-State: AOJu0YzYr+HyXdEPqH0G01JtUgUzL1GFYPaDdQPGLAyDkM+8ZcwTcuzy
 S24ezdE2uecSuqAD/G59e031v5sYtItmB2X6mud/rvUfHBZicBg5+dt2K1eCfz1EBH5tPUfif2N
 kFgpe8PGl0f0W9PSZNWM+zbU96nV7TGoCGUTlbHOrP2YZhb/rov6CLYDHJq+zdAHIXQ==
X-Gm-Gg: Acq92OG9vhju//RhkkTYX1kEbW8Frhmg8LyD+yeM/KsgiEY/ahkOnr8WeoQ45JlYRQP
 WjwyU/UEfOdMV1oht+DjoLxIfyVIXDsK6M/tXHocGkPEfOpNAo8wrzrxUDu4VfQCzHqExBCrpAk
 7x5COnnWYAdmSa4tkBpH4XUYjE1tPfk6eOPypDbala9o9DHNmfxuoLwgBt+tJYMSLlXeT6eSW0O
 1xjESiKctUV7S64FBfhqy3Nxam4Rl4Axg4L3dlAususl3AmGUhv1EcTkaL7y2m0VScShzlL8Zq8
 7elFAt+//pdA4fgmE1pcAOYN0y76wNde17KxwHu9tUc8kKY47888IVVOVQwUA4HPBweTvYAbdvn
 Wc/4fF6tRgzcWFlbysVFqv/G1UWZWPh/rV86JWn6JDzeZK7Y6R+YAmOfPbNuuf67Xsn2g0lbmf1
 ydYRWf
X-Received: by 2002:a05:7300:7fa4:b0:304:c520:4e0c with SMTP id
 5a478bee46e88-304fa4a97ecmr876199eec.6.1780091917706; 
 Fri, 29 May 2026 14:58:37 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa4:b0:304:c520:4e0c with SMTP id
 5a478bee46e88-304fa4a97ecmr876188eec.6.1780091917221; 
 Fri, 29 May 2026 14:58:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 20/28] target/hexagon: Add pkt_ends_tb to translation
Date: Fri, 29 May 2026 14:57:58 -0700
Message-Id: <20260529215806.608770-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RcCgzVtv c=1 sm=1 tr=0 ts=6a1a0c0e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PUAfe4L2FItr89aHCx8A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4Ub4jaauY4WG
 12ED5XWAkrWW+BDwAGFnAR0xO/T9D6YKmad4Nv9e7fOfm0mcUBPjIpr7Snf5ehNyQJfsbEdA1TT
 zCRK6WjpawLrv/Ez2lZYJKJ7OSVWQPnQDR0FKCLXylL8MduwNsuZIe7dGuWNZiU9t1gOiu71DMV
 B5+AXleGTD6tNQMInw/DU7UhtmdA/gVQy6zkKqBZB9CymjBy80/3eGjjOIcvum1sLrZ2zdCp4TC
 m10U6Kn7L4UAxymcNaRVfJtLUgT/nswyQm2HJL3Ahzygz1rURM/nmdmxBfRjBDrDEcsuVZXR4jw
 UxAjh3yUJuximuwBNKx9dPP8C/KXxIamPr7yzMPH4yxQAjYhrXma7dWxYghC/xqVzmngbo6QpAB
 jKFtOjojq2PeUt7jGcyEks06SO4hrlkR+dgqvykDiUJPDdDQN5P+1dfY8u5XA2AQ2szoNbw2ZuC
 Hm6QkgWZbG3QlRdg6Nw==
X-Proofpoint-ORIG-GUID: tJcHGemA_4jpQBFiS7Pa1z5QsSfBWK9-
X-Proofpoint-GUID: tJcHGemA_4jpQBFiS7Pa1z5QsSfBWK9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgICAxIC0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTAyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTAwIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBmNzliZGVkZDdi
Ni4uZmVhODhjYjJkYjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04Niw3ICs4Niw2IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOwotICAgIGJvb2wgcGt0X2VuZHNf
dGI7CiAgICAgdWludDMyX3QgbnVtX2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCmluZGV4IGNlNWJiZTkyZDVkLi4zNWU5MDM2Mjg4MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTI3
MCw2ICsyNzAsMTYgQEAgc3RhdGljIGJvb2wgY2hlY2tfZm9yX2F0dHJpYihQYWNrZXQgKnBrdCwg
aW50IGF0dHJpYikKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBib29sIGNoZWNrX2Zv
cl9vcGNvZGUoUGFja2V0ICpwa3QsIHVpbnQxNl90IG9wY29kZSkKK3sKKyAgICBmb3IgKGludCBp
ID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKKyAgICAgICAgaWYgKHBrdC0+aW5zbltp
XS5vcGNvZGUgPT0gb3Bjb2RlKSB7CisgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAg
fQorICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyBib29sIG5lZWRfc2xvdF9j
YW5jZWxsZWQoUGFja2V0ICpwa3QpCiB7CiAgICAgLyogV2Ugb25seSBuZWVkIHNsb3RfY2FuY2Vs
bGVkIGZvciBjb25kaXRpb25hbCBzdG9yZSBpbnN0cnVjdGlvbnMgKi8KQEAgLTI4Myw2ICsyOTMs
OTAgQEAgc3RhdGljIGJvb2wgbmVlZF9zbG90X2NhbmNlbGxlZChQYWNrZXQgKnBrdCkKICAgICBy
ZXR1cm4gZmFsc2U7CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIGJvb2wg
c3JlZ193cml0ZV9lbmRzX3RiKGludCByZWdfbnVtKQoreworICAgIHJldHVybiByZWdfbnVtID09
IEhFWF9TUkVHX1NTUiB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NUSUQgfHwK
KyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19JTUFTSyB8fAorICAgICAgICAgICByZWdf
bnVtID09IEhFWF9TUkVHX0lQRU5EQUQgfHwKKyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JF
R19CRVNUV0FJVCB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX1NDSEVEQ0ZHOwor
fQorCitzdGF0aWMgYm9vbCBoYXNfc3JlZ193cml0ZV9lbmRzX3RiKFBhY2tldCBjb25zdCAqcGt0
KQoreworICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAg
ICAgICBJbnNuIGNvbnN0ICppbnNuID0gJnBrdC0+aW5zbltpXTsKKyAgICAgICAgdWludDE2X3Qg
b3Bjb2RlID0gaW5zbi0+b3Bjb2RlOworICAgICAgICBpZiAob3Bjb2RlID09IFkyX3RmcnNyY3Ip
IHsKKyAgICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc2luZ2xlIHNyZWcgKi8KKyAgICAgICAgICAg
IGludCByZWdfbnVtID0gaW5zbi0+cmVnbm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0
ZV9lbmRzX3RiKHJlZ19udW0pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAg
ICAgICAgICB9CisgICAgICAgIH0gZWxzZSBpZiAob3Bjb2RlID09IFk0X3RmcnNwY3ApIHsKKyAg
ICAgICAgICAgIC8qIFdyaXRlIHRvIGEgc3JlZyBwYWlyICovCisgICAgICAgICAgICBpbnQgcmVn
X251bSA9IGluc24tPnJlZ25vWzBdOworICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190
YihyZWdfbnVtKSkgeworICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAg
fQorICAgICAgICAgICAgaWYgKHNyZWdfd3JpdGVfZW5kc190YihyZWdfbnVtICsgMSkpIHsKKyAg
ICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAg
IH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisjZW5kaWYKKworc3RhdGljIGJvb2wgcGt0X2VuZHNf
dGIoUGFja2V0ICpwa3QpCit7CisgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKKyAgICAgICAg
cmV0dXJuIHRydWU7CisgICAgfQorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyogU3lz
dGVtIG1vZGUgaW5zdHJ1Y3Rpb25zIHRoYXQgZW5kIFRMQiAqLworICAgIGlmIChjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfc3dpKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
Y3N3aSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2NpYWQpIHx8CisgICAg
ICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9zaWFkKSB8fAorICAgICAgICBjaGVja19mb3Jf
b3Bjb2RlKHBrdCwgWTJfd2FpdCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFky
X3Jlc3VtZSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lhc3NpZ253KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc2V0aW1hc2spIHx8CisgICAgICAg
IGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNF9ubWkpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNv
ZGUocGt0LCBZMl9zZXRwcmlvKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
c3RhcnQpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zdG9wKSB8fAorICAg
ICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfazBsb2NrKSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTJfazB1bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUo
cGt0LCBZMl90bGJsb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxi
dW5sb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfYnJlYWspIHx8Cisg
ICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9pc3luYykgfHwKKyAgICAgICAgY2hlY2tf
Zm9yX29wY29kZShwa3QsIFkyX3N5bmNodCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShw
a3QsIFkyX3RsYnApIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJ3KSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTVfY3RsYncpIHx8CisgICAgICAgIGNo
ZWNrX2Zvcl9vcGNvZGUocGt0LCBZNV90bGJhc2lkaSkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7
CisgICAgfQorCisgICAgLyoKKyAgICAgKiBDaGVjayBmb3Igc3JlZyB3cml0ZXMgdGhhdCB3b3Vs
ZCBlbmQgdGhlIFRCCisgICAgICovCisgICAgaWYgKGNoZWNrX2Zvcl9hdHRyaWIocGt0LCBBX0lN
UExJQ0lUX1dSSVRFU19TU1IpKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBp
ZiAoaGFzX3NyZWdfd3JpdGVfZW5kc190Yihwa3QpKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyNlbmRpZgorICAgIHJldHVybiBmYWxzZTsKK30KKworCiBzdGF0aWMgYm9vbCBuZWVk
X25leHRfUEMoRGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgLyogQ2hlY2sgZm9yIGNvbmRpdGlv
bmFsIGNvbnRyb2wgZmxvdyBvciBIVyBsb29wIGVuZCAqLwpAQCAtNDM5LDcgKzUzMywxMSBAQCBz
dGF0aWMgdm9pZCBhbmFseXplX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIAogc3RhdGljIHZv
aWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKIHsKLSAgICB0YXJnZXRfdWxv
bmcgbmV4dF9QQyA9IGN0eC0+YmFzZS5wY19uZXh0ICsgY3R4LT5wa3QuZW5jb2RfcGt0X3NpemVf
aW5fYnl0ZXM7CisgICAgUGFja2V0ICpwa3QgPSAmY3R4LT5wa3Q7CisgICAgdGFyZ2V0X3Vsb25n
IG5leHRfUEMgPSAoY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2swbG9jaykgfHwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxibG9jaykpID8K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCA6CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNlLnBjX25leHQgKyBwa3QtPmVuY29k
X3BrdF9zaXplX2luX2J5dGVzOwogICAgIGludCBpOwogCiAgICAgLyogQ2xlYXIgb3V0IHRoZSBk
aXNhc3NlbWJseSBjb250ZXh0ICovCkBAIC05NDQsNyArMTA0Miw3IEBAIHN0YXRpYyB2b2lkIGdl
bl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPnBrdC52aGlz
dF9pbnNuLT5nZW5lcmF0ZShjdHgpOwogICAgIH0KIAotICAgIGlmIChjdHgtPnBrdC5wa3RfaGFz
X2NvZikgeworICAgIGlmIChwa3RfZW5kc190YigmY3R4LT5wa3QpIHx8IGN0eC0+YmFzZS5pc19q
bXAgPT0gRElTQVNfTk9SRVRVUk4pIHsKICAgICAgICAgZ2VuX2VuZF90YihjdHgpOwogICAgIH0K
IH0KLS0gCjIuMzQuMQoK

