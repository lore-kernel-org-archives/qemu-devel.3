Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE714CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpQi-0001YF-3D; Tue, 12 May 2026 11:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpQf-0001Xw-Uc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:53:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpQe-00063t-C6
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:53:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCA7ZZ144593
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yguok3bUsK7SJ5TSJu5F4Ye44CWnsDDTB+Xdbkw1LH0=; b=GSH3zFvFexDO8DiE
 PVBUAXM7+nrGfwO3pfqatS9R8DFOzCutNMjj560GvcYwOpqmxg8OQcymJ0JxVr1o
 9JI5toClrIX0oamAIv34bD2Nr2nF3xJS31GrWO+ubhWpnfiQ4ZTvsJ2em7C07j3p
 8zmsP4M84nyd/qyP7VFDCX5f9MG6bJlspmeLF4wPEtg2fEjI8XEcIEIl07UKpP7L
 RzZ6FFAkFy4+ex4l/t1C2LGTlT46HYZuTR4G81ov6DLB1wTolcr2sltjIYe29hfi
 6dKdT3D42BmnHsERr8YXPBiY0gcTfeTRabbWHpqY66Nmuc+g1MckYxfO7+4oC3+n
 mMFtHQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43yp8uuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:53:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-132a99125f8so4885762c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778601230; x=1779206030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yguok3bUsK7SJ5TSJu5F4Ye44CWnsDDTB+Xdbkw1LH0=;
 b=AofVPNybqI2HATwPdM3gQZXkMcwXcdPSPbfaUx4uSXAWbZU4j/hUdhFYWxKiT9yaGW
 oM8WcoGubfxrkq5DwjsTJi7ouxDpDRjyu5rERtBrJl2McxuiqrsjUdXXWuDy/gL1grWr
 LqqS27HDyv2PeM4ZwGfzRsv4+q9zCIuuKDOdSrYhb1k7+tq0W82qlvR8quoh0dHj9ha5
 6DBaFghos4IIz3BG+3vx0onC3qMLojGjRIVpAKldO09TuXxWhAvbMQWF6bJU13hybT69
 dqTWHxFMf2K6iOuDE7xW1pS+GvvVd6e9IWXc6yDPWtP6eqfDB2Qf3i3PNAp5JVw3DqYk
 lU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778601230; x=1779206030;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yguok3bUsK7SJ5TSJu5F4Ye44CWnsDDTB+Xdbkw1LH0=;
 b=mkb8LuGgPCcB1yN6WK+voaJzYQ9L8yHd2nqR2L80OwnZQUlQ2zE8ANK7ZBIdajhNbf
 5sMoHlhYvmlqlcV91pYhzB8No+RvON1iXvPlYQTX9KyXlo9+bZGKo4isxrRuXdE8CCdZ
 BV3mYXK1gM5LYoqng++YZIQGt+alNAm1XthIasGNg3Ox6tjQn2y0vCPiWwYiaaErraJq
 KQl0tUs4PpG77RMcQTEYcssrRBrDLOh2OGfPr2pt/SRzdmgfxtCGZnQd0CkxDoKgAB9v
 mRZ/WfkxezMlWMgVXlvHoAc45txqulcgtMhMjXt4M9D/KknwiAjy0U3bryNCHLTn7B2S
 ofzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86Ul+z7hrIUJ3YI0yHJ0BxJqIWTNL7/qe/KuspTuQxR6f/AlIxHEu9XvAnr4Ozdv1yQfp/fvk/BgAb@nongnu.org
X-Gm-Message-State: AOJu0Yx+0Rx+MKCpFKbt0J29kVSeLAtAEDSFGjU98uT2BrrlsGVaAts+
 aDDpKzL5gah2Qm96skMszbotJp5ovZfogR6JoS9P7zwd8J+3XtKDBXPxc/D0wmRHyuZ+s9Liv/x
 ArjkQrFhnIbbsfSxRSBvRxDwcFFTKnBON+Wy+/3g0wyoafBYqYY68gM+IKQ==
X-Gm-Gg: Acq92OHQpOAjQ2Eum9ABFcV1jHuIl6oEHLuEGde3qS9Sj3BF9YSYY891QI2L18lugMn
 BF9YaTiXV47/TfYc8kArWE6Iw4A3bOvKTq8ZJAX+lpxYmVFUF1t4IdVw7ObCqXnmydSJdsAHZVt
 7Inhvn8IZqWjsh9XlzvryrMUtBZd7bt0qi8+DOMGGlyj/qmJqX1WZGd55rzFq3VFWBJnPh27e13
 zEPiSnyq4TwYWeghnKAfDI2rj+uvKXfDCvmFqgB1Qv9E79QJBpU+jL2CjABPfTkE5a+2h2MCBXd
 khY+A7Q8hoVqwKhVJ2hNz/5I6EvPXdKoLB2+eWTVSvJ900HGBYyzxqiBNSt/iqz0mXqykXzxaCG
 mn1Ss+ak2BEZ8RGSsskeWvV8Dl7obz769LEyzJST6QT/HujxlZEIB71bKeJTX53LRLJ/1iINqy4
 R3S8u/3zvk3PxnVA==
X-Received: by 2002:a05:7022:ec16:b0:130:ab68:2b6f with SMTP id
 a92af1059eb24-13344b3aad1mr2182543c88.9.1778601229995; 
 Tue, 12 May 2026 08:53:49 -0700 (PDT)
X-Received: by 2002:a05:7022:ec16:b0:130:ab68:2b6f with SMTP id
 a92af1059eb24-13344b3aad1mr2182532c88.9.1778601229414; 
 Tue, 12 May 2026 08:53:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f885edb83fsm18047244eec.7.2026.05.12.08.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:53:48 -0700 (PDT)
Message-ID: <92e4dccd-5f0f-4268-b6d9-6236fa5ed219@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:53:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] tests: validate dmsetup result in test 128
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-13-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZvTWaFzo-SsmWonNt-xBP7AyRO-u7QFh
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a034d0f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=SQPxrGs833apBfTXCeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NSBTYWx0ZWRfXyWmu/4g6EeYB
 SbzpC+raDifxdG8yy6wPRX/7kbjdaY6h4pKv4wNmGQxkOEd9tgqh0UxcrHfDSrp5OVhKT2bSw5A
 N6ba8tVZhypN+qtZUtW7qPo40XxBdjr1ezCfzhQiqIUfHodEAC3axi0A+k4WrbN/UYOrPVjkejN
 FYtHnGNVPfz8Jb7HAwjfuqZP+RE8iX9V0FwTNSHk3vv2mB0qAWVzX7kylXeJbXBj8vvIbjg1USA
 NbFfJOp9WoQmbh8Ww86Mqy7D/yt8dzNo95kr5TpsG9YrQkn86darodoaW4ax06wh583mb7xIzgD
 a1Qe1+IfW0nTKIfY/6L/P+VO2en8h6UTkKrMQjHIBKPAgEjs8LVOcow5n0LaRMcDw0RiVlBr3gs
 5Csn7wL5ZgxFyMT05hBspXC2KYp51INoeepYOui8/Su6Kw5SVDsc2cHo0y8g34JGjpkjfUtbVUh
 GLLvssYPiTT+Fo6+6EA==
X-Proofpoint-GUID: ZvTWaFzo-SsmWonNt-xBP7AyRO-u7QFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> The I/O test 128 uses 'dmsetup create' to create a device, optionally
> using sudo to elevate privileges.
> 
> This dmsetup command works in GitLab CI, however, the test then fails
> with a missing device name:
> 
>   1..1
>   # running raw 128
>   not ok raw 128
>   ----------------------------------- stderr -----------------------------------
>   --- /builds/berrange/qemu/tests/qemu-iotests/128.out
>   +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
>   @@ -1,5 +1,5 @@
>    QA output created by 128
> 
>    == reading from error device ==
>   -read failed: Input/output error
>   +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
>    *** done
> 
>   (test program exited with status code 1)
> 
> It is believed that this is due to the build env using a manually
> populated /dev, such that the device mapper node won't ever appear.
> It is not a race, since a test adding a sleep did not result in the
> device appearing.
>

Could that be related to the fact it's running inside a container (if it
is). Maybe it's just missing exposing all /dev instead of a limited set
of devices.

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/128 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
> index d0e00d24b1..d75b1a451a 100755
> --- a/tests/qemu-iotests/128
> +++ b/tests/qemu-iotests/128
> @@ -42,6 +42,12 @@ _setup_eiodev()
>  		echo "0 $((1024 * 1024 * 1024 / 512)) error" | \
>  			$cmd dmsetup create "$devname" 2>/dev/null
>  		if [ "$?" -eq 0 ]; then
> +			DEV="/dev/mapper/$devname"
> +			if ! -e $DEV
> +			then
> +				_notrun "Device $DEV not appearing"
> +			fi
> +
>  			sudo="$cmd"
>  			return
>  		fi


