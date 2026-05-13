Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE9ECD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 16:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNC0N-0000pS-Is; Wed, 13 May 2026 12:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNC04-0000Zj-GC
 for qemu-devel@nongnu.org; Wed, 13 May 2026 12:00:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNC01-0005c8-DC
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:59:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAGS3F2321233
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 26v2rUrikTpVT2c/QXUivP+L18HIlVBwHq1W1lON5to=; b=OK3rfbVHlUWKBOGb
 CB41tjJrfAvMZ3b5hAjVN54XsHU/VSvdGW3Bc2eg3Rm5Ui9b0zNBTVYmjUo62E6/
 z8uD4YZZHFIfJVnVgTrH0Ugtri307f4YL90lTRdy8i2lzyDEh4Ud81zAUPgvz3J9
 0GuQKcV4KI5YptbEvtASPyvPbrBXS7YP3GEpYGtt5tjkAKhJKXYWEKxEdW3oPHmb
 GHGbH39RviNvjm18xhc6kZWjT/5aeKTXQ8XftJ/p4zWSoMgIjFX4L+6dVqfBv8NQ
 mdueAgz7axISTythy9mnCGo5G0qRToWFd55BJBVt92nBhQYaVvCQ/ItbaX/5SZGr
 5xc7Cw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hguatqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:59:50 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-132d631edaaso20008621c88.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778687990; x=1779292790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=26v2rUrikTpVT2c/QXUivP+L18HIlVBwHq1W1lON5to=;
 b=dV0w2v23C5cA+8y+XdqGo6/PVhkUiLsigKesmr6cUAr+jjCkcP9q0R+42N5TavWX1E
 aBgjySoVpMKM/SLhks62CHZq0OLhJBoWU0KD99cfx7lXGCUTbYirS7udH3U2unaM5D6g
 DXppbGSA4HQV6ixiWP7S6wJDXdBB2zZO8DYex8onVf881gYiryaM+qUAz6+TU7AzZ3u/
 xWNmoKIEZpgCLlNUlo3dBELBPCj8ErdT05+cXazUESMZMw7RUyCqDm68tTWFz+7eS2vN
 NkPu9fZHBFd9v3GBb9AkE05lNSu0q9gLB2ejqseeb1tr4ZAL2FnFkktyErRqH+d7w0ub
 Jj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687990; x=1779292790;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26v2rUrikTpVT2c/QXUivP+L18HIlVBwHq1W1lON5to=;
 b=rwN3GJ5tnwsS+8vn35o3F1n7dJ5wys/5lB0k9LvwfRi12TbcNOTlMFokdvieQQzQhQ
 +J9XfjD/xExbDeyuBQzXTGrmmwPAPcWQTdj1XT+gnqBVFSm+r3bo0gr7nr9tdzJEKHLa
 4CfSTRVTb3SLTQo17Qf3Y3eFpSeYSg11mCaUzALdFKD5NVP/qYLk7x4BUJ7fSGTpRIb+
 AX8G2ATFKYsUNB8PdQMbPajXCyNraFrZ1YpUSx/QqrDDAaoi2tdeJU4MstwC3lAkthZV
 W5uoDTOoXb9JY4jMd7T9FqRUEaUDkB4n2DvTk360gw1IfG5dhcI/i5D0nVuSv+KItPSx
 CfjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pkdBbfrr5bpJJo2OkbktT7bIrTjZo3Tr8sfjaF1/QQu9l0mZ+ohKxYRpsGDL5MceoDIWkj6RIAm8N@nongnu.org
X-Gm-Message-State: AOJu0Yw1GJowLFsqvaoKYX7wE5BIj4Unn4vxtHayRjTXkJA2Xgrw69z9
 lkXavn83uMl1wySFUrKpLVaNur/LP9zsHZHkch8hpVCXozri729s232vOCrjk7nz7+vzZ4lQdSW
 wpVjV3jDxYljubEelKCou44FqUmFexpF+7t7ooBqnmUGq12G41CZyM+S6Hg==
X-Gm-Gg: Acq92OHW9fQUneLFdkV39wWIq8QjRZYM81OfOmlVxob8h4UkkDC0JDqsLHrkT1w0tKX
 zwwhme/3UkQBvcV6ypKwZB+oyxh7jWGmlU8aSLce2aouANAJ97wq34CZGxqZKIHjI0V2ogPd/FP
 8iAxqCag94vFFYgKM+vhT5/qbCJ48Dt8HTGuAEbL/kCzqvlM0C9I48gCJo3IY1oh0hUV/B2yJyg
 Ok+4U6SCsthNv09HF1Fhxa4oLI1MItsZC+kQF1sJzKX9bP+B246ulibGnoG0lqb+NL9GvkfgbdY
 NuXR6szt8N3gSF+NrlDXUeNoeUSsUv7cPOeN9fD7nc8UeD4K3nyCh5c8MILxJ4kmORgNuWNW8aJ
 RvikStpjViVb/nk4VGfR1jXxmejz5Pl2Y8+Onxd8+qpfcj1bS3OM23knAE8YxWdm21E5im27Bx2
 +Fn1+wgAmGGeSYsA==
X-Received: by 2002:a05:7022:6993:b0:133:12af:3fea with SMTP id
 a92af1059eb24-13439c5e4bcmr2311789c88.43.1778687990030; 
 Wed, 13 May 2026 08:59:50 -0700 (PDT)
X-Received: by 2002:a05:7022:6993:b0:133:12af:3fea with SMTP id
 a92af1059eb24-13439c5e4bcmr2311764c88.43.1778687989458; 
 Wed, 13 May 2026 08:59:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132781103e7sm29350121c88.1.2026.05.13.08.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 08:59:49 -0700 (PDT)
Message-ID: <d9618601-8998-48ed-9899-452b4e4f8cf0@oss.qualcomm.com>
Date: Wed, 13 May 2026 08:59:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/16] tests/qemu-iotests: mark 185 as a flaky test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-15-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513120003.226790-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a049ff6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=NQfeE6i2tCqMoKO87K4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: nbm8rEYJVprMmKFqnMqiUgUitnaY7whm
X-Proofpoint-ORIG-GUID: nbm8rEYJVprMmKFqnMqiUgUitnaY7whm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MiBTYWx0ZWRfX5Pkkt/W1Kpb6
 JLwIeoxHHylQs2FTK5NmHpsFYfer2MnEMRYvqWxkn77VjFbnBfrtypHhrd3x6O2kHGaguI4EBSK
 b/5NL4S7H6JrBLSHDjx8xsGExK9wPMTn56BMqte6IGUz6FyZIqaKjgdSADVA4/aGSl2t6uBA55Y
 hLOv0WE1AQa/L6LVcCQyFQuzxPtnPWOE8CnaRLEtdD64uoCGPydxeZ5mZV0GT9QFje+RIATq5G7
 Bx91bAnyL3qNyR2bseR7avHhRa1HNA74lRD9jvPx24r+qdR1E8BcSOByDQRJM1tTS34NPBXpli2
 yKqBj5PQoyL9qErZbCXw3pCoQPXceoonOtT58mbG/8dHbTqhOqIDCuCFanA6qJkvBwwesEtk1Ag
 zOuGBzJPuijorJUwBZrCMHndSRVdL6xk/5yG+ey7U+KwsoOiQqd9du5nOoXcIltYfoEIWNTUbbY
 EV8oNA8CjpH6W3EUrvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130162
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/13/2026 5:00 AM, Daniel P. Berrangé wrote:
> Introduce a "_flaky_test" function for I/O  tests which accepts a
> GitLab issue URL, and causes the I/O test to be skipped unless the
> $QEMU_TEST_FLAKY_TESTS environment variable is set.
> 
> This is used by test 185 which currently fails in GitLab CI for
> unknown reasons.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/185       |  1 +
>  tests/qemu-iotests/common.rc | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> index 17489fb91c..a62ae8d329 100755
> --- a/tests/qemu-iotests/185
> +++ b/tests/qemu-iotests/185
> @@ -50,6 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> +_flaky_test https://gitlab.com/qemu-project/qemu/-/issues/3270
>  
>  size=$((64 * 1048576))
>  TEST_IMG="${TEST_IMG}.base" _make_test_img $size
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 731e4b2b99..298bc483e0 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -1088,5 +1088,21 @@ _qcow2_dump_header()
>      fi
>  }
>  
> +# This must be referenced after any _require_  lines, so that
> +# test filtering happens first
> +_flaky_test()
> +{
> +    if test -z "$1"
> +    then
> +	echo "A GitLab issue URL must be provided for a flaky test"
> +	exit 1
> +    fi
> +
> +    if test -z "$QEMU_TEST_FLAKY_TESTS"
> +    then
> +	_notrun "Test is flaky (see $1) and \$QEMU_TEST_FLAKY_TESTS is not set"
> +    fi
> +}
> +
>  # make sure this script returns success
>  true

This looks better than first approach, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

