Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C534CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQv7-0008Pc-Uh; Wed, 24 Jun 2026 12:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQv5-0008LK-SW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:57:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQv4-0004nf-Es
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:57:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfXXj3214734
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OTwE7mRVD5d3qjp+fPQ+Sznz8irjbWFVXk1TR3ZY47U=; b=cz35udagGNPB/gkx
 JJe+AtopLO9AHF7RFZ3tI0stDxaEhlwsWZWZm5yCNceUBSb4SxQVihM7rcoiL1o3
 ZdeYOKNMm4gIbPeI+jIMk360JBEQV1MZqx7/dzqHDjbxrhDrirAgWgGJ8/jJyCBH
 rB1cUZ/LeojSsjjdouFudrDy5EEfRvzvVFl1PiOH/3uLbnJhSuuB8n5VAamy2Eql
 uYbs8B28HZMUPzkeAupKR6M80eons73F8MgjuEoEJdQM+2BW0HA6eAqwRsqXD1PR
 xniWYG8OipglOvlK6U8qcEmPssEtHQw912LgMkc2NYq5TGoYXydYMkaWczNgczNy
 /GZM6w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05bfbakj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:57:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so3083185eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782320264; x=1782925064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OTwE7mRVD5d3qjp+fPQ+Sznz8irjbWFVXk1TR3ZY47U=;
 b=Z7o4JIy48SGKvpcp0Ueu+yo1yH/c3rhG22n2XlkHXfZepwu9RpyGTabuT5GP+bx8pM
 y3jXk/VBKDNGgZDDUBMBblEzAQqXr8B41uNZwNaENEdN/ck9vSuXfpW81QzK1+j8JPqY
 pPMRgUZjk+B2k8dQcqfqG/pWV5ibM1842VadBUURoJj0/ZoeeeYIfCOZ0YT47rPyeRnc
 WQAQ0f5k1H1hgHsQIlv1SGsEpOjPQ2+1Bv2IypzHCYq6UrdWK/xXxnv4R/iJ/7wvHibr
 oBmwmNLeBOI97dlYrHIEo5LOehiQPMMlZwrrDvaGbtwnh/dOqyELS22sCBj1v2IrSIvx
 XGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320264; x=1782925064;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OTwE7mRVD5d3qjp+fPQ+Sznz8irjbWFVXk1TR3ZY47U=;
 b=LSStoZ7jOsCQtSyqJYYq1hr/FoLPXvlOETpxnqHxTuQkR09Y6uSwSmSjrswaAQ1Tzs
 JsyP0FV41CfqOpZnjKirGEQM1Jb6NhIuXQpYQU/gDhU4DrT/zvd9m4H53dZPZfzPbjze
 FTLdrkNBWz1n1cxKN/GT7mZpUSfsH+3xrQ7Hh1dHvsy9Hj6Li9f1MqwXWY8rDuVrSI09
 UgxFpGypUPEDX7938LpGzgpgJvnIiJdbxrGw73Wz/MsDfSPDYY0J1OFCbdvVQVjq8SQk
 m6wDP0ggCoBwdXO6MBwimpaLGWKnh3B5EJH1qus+Hmxy4VvQxPNXUXdclGKQ/53UhBbX
 dq7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBEIRZjDVV8eP3ziFQwDpRaj4Rz1mCkbfxb4OTFTs5ZLPX5Uhcp6+pddsRiM0Nwa/pNs6nDLzlm4ZR@nongnu.org
X-Gm-Message-State: AOJu0Yzu4DceJ+d0mE+sG7hxOCOf18jc7wyEHW7jOGsuzA3CrAGbhpo1
 9Aw/IZFeQiU/23q/l2fFd9nuik0UhO/uEHX8gJshn7Lk8FbP3YPCl98IZyJ5f44E8M1sWwnsmlF
 aqYPVdA7sJ/fhFiNpimnUxSDSq7PVukPI0yRXkkUyujC07ckhDUVpBCNNuA==
X-Gm-Gg: AfdE7cm433PK8+LsTuRZ1xhgtcqZ3Y7SUc85Ay+KTzTAW7/WuG3goEPbuIBQrWsJexj
 OPQoRH4rO5B1lKcbu4uY4KPEPe3hplausJ4lHCLzKbF3sUX07GEeq9LXlcPpaSBeBBx6k1ZBz6q
 4U55cYldTWAdzh7RbiUjTNI6W32wU4iFHqy3+U08Avk5Ohif2YJw5IxcAhwCy3Ouackekd0jusn
 jIrh/v98DY+SKOiIBCxay2ACFP7NukTrsc5UAHeNuCgpge16xkiSMiD+wj75CU9oORJSAxeNQCX
 xajYf7vT1JsRS3o1nJmvkplKT9Pqy+VVJI6DwQx9uV30jliwQ8JYjBwedkUgFZr3TTrhALZFL65
 UGSWX9KhJaX2kOtX+dCZ2vy2HvJCB3Wi7dJXbHKbvsHw7P/GGqMknoLvPSb4AaQbcVdmRXoCFcV
 DQjGw=
X-Received: by 2002:a05:7300:30d2:b0:30c:43fb:3a69 with SMTP id
 5a478bee46e88-30c691290c3mr4199922eec.6.1782320264170; 
 Wed, 24 Jun 2026 09:57:44 -0700 (PDT)
X-Received: by 2002:a05:7300:30d2:b0:30c:43fb:3a69 with SMTP id
 5a478bee46e88-30c691290c3mr4199900eec.6.1782320263719; 
 Wed, 24 Jun 2026 09:57:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca87caasm380792eec.27.2026.06.24.09.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:57:43 -0700 (PDT)
Message-ID: <e77668e2-f20b-4ec0-8296-c86be38573c3@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] gitlab: pull ccache setup into
 .base_meson_ccache_job_template
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-5-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X8Bi7mTe c=1 sm=1 tr=0 ts=6a3c0c88 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=g0z0yCjihklwhGo_mmUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: lTrQSuiZ-VqNRXieAyTaT20zzCJ2PdMG
X-Proofpoint-ORIG-GUID: lTrQSuiZ-VqNRXieAyTaT20zzCJ2PdMG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX/VPvbiX12fax
 wiXdNOQ6Dc6g7vvm9zvDvfvFBomV2FtRrSKGWp2sgtfvrQWmTUuEaYRwkdvx5IohYyIrcWY+KPn
 ktOaIbMLHbSAluNnbBOD+3aCJB2Uk8w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX2bvs1ue+JNME
 tYvzyxaI6HdWL02YXwE3gU9NoxcTFC1uqZIHKIpQB95qqtZirCW+fmWR3pZHzPDY6iLyt5wFqXW
 FwJZxNMTOpVaIFWUfLmFDbs84YDQj5L/ozmb2xbL15M2zQDhVOugoa/si6Y6b+QCbx1BMTmoRbg
 +sVIuiD4owOVJsQcT1FgxvMD8z28/Q0FHNbN/q2ptiI9MkofRNDHyAd+Z0AkwHFNia2e3Kdl3BC
 K+lT71l4gUrOGdRFlmJE1nsuFP79B/uVuJ2nh+mHvDfNNCEDyAqJfY5DexAo5E6nsrHghwct3Ep
 n6cvfVwMI3AhcYnmrNGK7S1EG7AOQwViSSqhTU7OWGGAftHJ7cyJVM9VvMWHCJ4W11uV7gP3jLo
 Hv0cqrc1paSy6ZRRev1MxEbGwGmziA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 6/24/2026 5:46 AM, Daniel P. Berrangé wrote:
> This provides a consistent ccache setup across all build jobs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml                | 16 +++++++++++++
>  .gitlab-ci.d/buildtest-template.yml  | 14 ++---------
>  .gitlab-ci.d/crossbuild-template.yml | 35 +++++-----------------------
>  3 files changed, 24 insertions(+), 41 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

