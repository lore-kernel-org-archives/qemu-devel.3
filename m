Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7084C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3du-0003Fz-TL; Mon, 29 Jun 2026 00:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3da-0002uo-R5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dX-0000lO-6h
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4Nk191778146
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=; b=odlaV4ppDYyAialf
 uD/Sulk/CjHjVwjNXGFCNmHUnRbykhrmkyJaNcYAEa3BHeuJKePeuV4gIO7nlc+T
 xpXtoaMGMUKM2alcrYy1FqT2ajuJSkhkVAdJiorq9s9sU5XahyHZFW1nBqovLtG7
 RnuOdFV+OgxZdcgLyEHqKDZLXqthBIF5D+c2Q7EAya0gP1dj/rNesE/owwQndwAy
 +pJaFYNcugmfcZTlLyYeepY2NEgS5NJBaOXVtCFciMTq725qBmYD9zM1pdr8Awsr
 b3iUg2/idXnM8AAwkjg3lB4cPW74juB9g77+3/1vyO0DNzfmLu005WkZYEqAhvjR
 4MNfSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mg7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:29:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso10828460eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707395; x=1783312195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=No2h2rlBig7A74SeQP2vKFdMwR08EZa2bK7Xv+dwiQJE4mN1Tlv5Ar6Ib2RRZ866PY
 3sroP7em8+Mbbv5Avjykyj7Dk69sbhyw2yveyCCi23Lfv9ekh+qWkZ8spYAA5Nes3VrA
 dNzxwxa/5XUbK1ukiyziO/j4ZQxiqzrchvmmItcxwQdmdMh3kw7j6v/Cgd8J0sx5FsS/
 6T/iYNzsMxkyMVCl++YU09IfKFuelKlO2SB6An2SBJIpD82kqxFObH6CHEVHp+ykP9uA
 3MWr0s3p9BhIkUC99AJS3dC4rcCpY+k3usduD/at1OaGhQlaoil9gstW/6K5FASAM+92
 ZytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707395; x=1783312195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=n3tTX96eedLE7fp6sbDakgbFpMRWwT7GBCU24M3eHW0OfZU243g7AVqJod09uYQJiS
 DO3/QCUVFeES2WJ/ovQAqpFPMSoCmeQh1mbd0d5K+dfeJ6q1B95b1TTJ9/kPduYLGZW5
 zGweJNk8P+uhYXNPmI4Pu0SIhF5I7J2xRRIbnyC/oSmb3XXuaFN4OlBLg/DkJzULj1hx
 9gJJvJYGxk/CMOTsYCKHGZlySsEB0J+JqdaBG6q0BS/xEaj7u9GECICVXNE+UTVo6+e4
 Skcj9EUi1CgRsVm5gjJdDMYzQxy/2wdBjHXm9KJSE4FoaurrbuaUIJZm11mzj+RA+Nmf
 UeKg==
X-Gm-Message-State: AOJu0YycqUWTjYsryTT+tZhUcjpvvnofVt/o9wUhEyd82ZqSzy+5A2hl
 6J3kmwLrQMwiZcQI5yP9EfHAE5oQKEfrpVBidan4xNhMiKOPRqAlqGE/ngiovPuRSVvc63sxHqQ
 KAbpNQZDrvohpwygaC6HpdKmx+giqV+CGIGVPsUToeyTmZm2Eef+3zy4VczkvqxosFQ==
X-Gm-Gg: AfdE7ck+vEOjE0q3cb8zwnnpycsJrcqrQ7hRCoXeBcGMMSO/1zcRU7eZ2UcxbYbScP5
 WkG/gYyl8cRxJHB4HmH4f+GabcLE422zMDmi/2O5wuSkW04OgMxVTIVWuylN4wyd3+x8TLOLMIY
 I6g+TlRJZnCyRzOVab/e6Bw4WL8PXxa2Z+c0WejRSgSROwbMantfAybs4Uj1GuVErIihwaAECu4
 K/eKQBpF99T63fzTPhMRFvbcW/yciw/GqetZd092jacZYsxXSMSF7fjsCADqJZp2tzjpk++UcuC
 VmZV6s6yB4sVF7kIpLgs4W23830HOswSTDDZgOHKh3EgEgNVPf/1IiopACZ3lwg1IKp59qRy9IH
 03WTdvgOV5eADquRwvsGCSeVBp8V4oZGZl35yMDMwkEA1Sl5CnMTH5WdIaWw=
X-Received: by 2002:a05:7300:6cac:b0:30b:9e56:e547 with SMTP id
 5a478bee46e88-30c84b94728mr14306086eec.6.1782707395296; 
 Sun, 28 Jun 2026 21:29:55 -0700 (PDT)
X-Received: by 2002:a05:7300:6cac:b0:30b:9e56:e547 with SMTP id
 5a478bee46e88-30c84b94728mr14306068eec.6.1782707394798; 
 Sun, 28 Jun 2026 21:29:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:29:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 51/77] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Sun, 28 Jun 2026 20:58:04 -0700
Message-Id: <20260629035830.1520296-52-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+EJiqYEHcLFd
 ZIbDDrGtM2M1ey0joCmyeCoPL6wfX343Qfhvl/EayTm4YGinncYoa+qHv1IkA4w5AD6tt5lVmQU
 O4sxc4ng0VRs60ZmwGPNl5vS5jW4YSA=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41f4c4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: LXrAXjDcf8PU_sDMX4JXfX4HDuysMyr9
X-Proofpoint-ORIG-GUID: LXrAXjDcf8PU_sDMX4JXfX4HDuysMyr9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX3E528teCVR0W
 57MN2rQy0GS7BX4pTjNcqJcmnuntwyu2vcLMH5ORgnKcsTvbHtYw29CSkKFz1ihit9iNv0uf/5u
 FDp6S/S6ZLTg9j/qt+FzKf1dvS4Jg15mTlKoZUnC3PR05yUmi8gniAT1SsYRWDpwkifrevk/nH7
 PmbTtou+dnZSvgAcsXUzR6SDrFyQ5SPMYu+9nix2nEuefSL6mxVOjb8LLpWQhzz/PVtF/uuYfx1
 Es/L3bnnNMQ54SOS+4NXryX9u37deoSE3HrtUnU6c/3NBTRVafr4g72UChYyHfrGn0zrFYGq3+R
 1NgsIc5JOF94sENIL6bI374iJKv/MYwk8iK1SmwuypYf1YxVWzaBBuGYrU54Vai+CIe3sG105Mr
 PF/PiAbO++o6j1gwMihs/ywsSHlXQO2IiTAxe84g/3Xd3h4GOZuP8oQIiPL/mp1GPJ0ytSjeiqX
 pwvQ+PwI+6ZHhZYRkWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MGQ2NTUxZGQ1YjYuLmVkZGU0YjFkYjg0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDk1LDYgKzQ5NSwxMiBAQCBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB2YWRkciBoZXhhZ29u
X3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsIGludCBtbXVfaWR4LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZhZGRyIHJlc3VsdCwgdmFkZHIgYmFzZSkKK3sKKyAgICByZXR1
cm4gcmVzdWx0OworfQorCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29u
X3RjZ19vcHMgPSB7CkBAIC01MDksNiArNTE1LDggQEAgc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBo
ZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9pbmRl
eCwKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIC5jcHVfZXhlY19pbnRlcnJ1cHQgPSBo
ZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdCwKKyAgICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9w
b2ludGVyX3dyYXAsCisgICAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LAogI2VuZGlmIC8q
ICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

