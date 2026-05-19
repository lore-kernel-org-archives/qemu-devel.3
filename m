Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EA8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLWI-0003vm-OH; Tue, 19 May 2026 10:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLWE-0003uL-Nc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:34:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLWC-0004ut-Qd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:34:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JAhQxI867065
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 95kjqS65FAnFpigyyzYtWaA4xCkotj65/utEcEij0o4=; b=Lyoi4wvquP7o9fnI
 IbTsA+pqqU6JfyBZgtb3TzpPQxd7TWNRXaH4TQyII/JG008k1DfmTQqVOhRB6wk5
 aXVPjvscbAl/1oN4W+jGmMQ8Qaqv/UzdY8Ru6EKNkF8AG4gP4RVq8tAqLEPB8EYZ
 Pwb4aUyrksgjjwL+GwLZlbfIC3lOFvTEdYxE00AwERy/DNwJyISTJOLx3ZybPojW
 8/8qiJafchoHjyG+f4OnLorNqssDUx6xQYuLnKhZLajBsR3NmoVjvgW8Y5d/kTrF
 DAKLfg+neVe+fgO3uLaeRwgbl28HUhSgCGEVhwilpxs4ZCMIgf3/8HZp/HXunRDZ
 4V8swQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8hv1j7x1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:33:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13537722193so19184619c88.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201239; x=1779806039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=95kjqS65FAnFpigyyzYtWaA4xCkotj65/utEcEij0o4=;
 b=MyLK4i061xivAichqJdd3v+iHnw55R44B1ngD8ovU/oj97WbJJ/JaTvRujGqLyZMC0
 6kgQsPSj530NjoIwuOe1vnPvuPkJQrTgA8kTxuB9OUMEWXhYEKdZSmHVgOazsXYG0yNb
 ag03eloY8s5vb9rbdhvPcY7dvcpH+0WiF9ymq14ikp82WlkcC9Z2DM6IvSFO4+e5N2k9
 DImXqyz4T9/pwSRtno+6aBtHPfgDQ1kBhqE/vCyYutAjl/04FfU7JNlUWUcyALXrw7hX
 Ml9kIPx+aZVkyT5uL1esO3eTRRIwk3rJmAcbpCBdI6hXr6OxzZagFfEznP5bkaxQyhIq
 PWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201239; x=1779806039;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95kjqS65FAnFpigyyzYtWaA4xCkotj65/utEcEij0o4=;
 b=hJJ9jBJuXMucI1jTOrHV8c83YCm4VyzzntcoaPLpoTtoHSpSuAmpxNbo2mvrISw3Cj
 YplF4TW0VGCXh6t0boaNeeGrtUpXfCCLeoqrW83mqpC3hEpPqPKMWXHy5fju0ApjLDcq
 u5fpKVnXF3Ld86dzfpTT4N7gZwXwyXA7W+XmAMIcjnwU1wFqU8136ikbS+sWVsaSBfX3
 DRnO2kZ1GSxxRiVCeX1zUYL8gN2OzeocgDvRAhO03fyXFUmTy68oO8OsPbO+2pLjdoJa
 lAcsEOx9PpeE2KN5sn23kTiTZmOiHE1WGVhBJTOd7yAemQABC9HMb4i6Ls1zJRg4x+CT
 JrnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mcgzevSPYJwUJbHVKDI3pfk6ph8Kk9xhjnFpb2y4fppfhIBfGOk6E9ykUoCZwQyMm7ynucVT+ZjFo@nongnu.org
X-Gm-Message-State: AOJu0YypycyKWWzPdktR53ni/fJwfve+XUThig38NQRwNI+7tAsv19RD
 R4yp2O/lTyyDk0Xyp2lDaAK0hC3JtLds/tB78yIHkra+jRUPXT6PdSJ6182cAl2vn8epJQd+psq
 YwxTxFZeP3TmjNR49MSZlOnOmPiwsnMaaJw0cqmt9REMko+IRYlqT1howYMvDddU7EQ==
X-Gm-Gg: Acq92OGPGD1IGAa+nnELH5iP136Qqlzg5Pir3nFXe22DuvX0d/PrpFsD0i/IN2fHzgh
 D22J3fFpIU2/WlC9/dZWT+D3x26SqRo+xgqK3aiv4JvvjCACBqu8jN5ALs/o8fJieyUHzUXBGnQ
 mq3pEgKZg8hfSLvjTGgHA2pe38NVO1ntzd7pcQ1HrSf4Ws9vb5j4bhxeYHdqC/HQDoADeYgz9IE
 dDhWzQtDqi+VEiCvx/aDsnoZ6ea7G3lmPtzmRVc4szIk++k9CtBjp+SWlZOGA92Ddv+Noy/RVaF
 FtEWhFkwBR+hrYbjSPtv0sIqMzbHSMTus37UtYBn0JTV6PN6Po0MykdyTyV6VnwziMQHcncwXdc
 5z3GB/qzkM0qw8p+cQFBn0194SSpO4NtqY9ADvgwFFRqoXohNdPuJ7u4=
X-Received: by 2002:a05:7022:128c:b0:124:9dea:188d with SMTP id
 a92af1059eb24-1350483d04amr9398796c88.30.1779201238818; 
 Tue, 19 May 2026 07:33:58 -0700 (PDT)
X-Received: by 2002:a05:7022:128c:b0:124:9dea:188d with SMTP id
 a92af1059eb24-1350483d04amr9398762c88.30.1779201238283; 
 Tue, 19 May 2026 07:33:58 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2352f2sm23170416c88.10.2026.05.19.07.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:33:57 -0700 (PDT)
Message-ID: <97c41220-7bf6-4671-a7b8-08185c3a882a@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:33:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] docker: Remove LegacyKeyValueFormat warnings in
 generated files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfX3e9Kyzr6quP/
 4XEwYvKQYZHoy6kkU7LrP9MLIF0S6CGMwtSEffwq6mio0IXytCgI2BtShaTcZoovPmUIRVcSLhA
 SREHpbbMk/va8+mOnaSKIV6dRlkoVnHymdJGCDnuKkXDsQDYfPzxFUxlNxeidui7UTSBFFZL7b7
 wuWG6EFG2EIDjcBpU5p5yMMnNVumBbO4fApG6I19AtzQLw/SYA39m9CKfv/hA8CiWipG9IWBmte
 VtVAGhVN8YPF4xz0s6r2azrXsi3rnOgm/KCV0mt0eq29q9fmPbIC/SNoP+SpDl7hafXY2WLg4W/
 7fh3egW0UqNizwW0KJK6HKEjF5d63gWn/gUi4LRWGPLCgDKjCFVmwfJYnfW2Lh9813IVRgQOPAT
 F5TietvHY+UAQ6uc0IVgcBbhZKGFpiEenzG6M4LbP0GK3buhDF8/0xYOB+Ila/3zUy/7YjVrSj9
 44yKL4vAAJm4NaGS/8Q==
X-Proofpoint-GUID: 5XlxMaC7jmxJJSdgFeu5giIzTtySSQ-a
X-Proofpoint-ORIG-GUID: 5XlxMaC7jmxJJSdgFeu5giIzTtySSQ-a
X-Authority-Analysis: v=2.4 cv=WZM8rUhX c=1 sm=1 tr=0 ts=6a0c74d7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=n6MYwUk4AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=NI3Oe7JmTeknEAL-lSEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190143
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

On 5/18/2026 5:22 AM, Philippe Mathieu-Daudé wrote:
> Display lcitool changes before generated ones.
> 
> Update lcitool refresh script to not use legacy 'ENV key value'
> format:
> https://docs.docker.com/reference/build-checks/legacy-key-value-format/
> 
> Run "make lcitool-refresh" to update the generated container files.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/lcitool/refresh                                | 12 +++++++-----
>  tests/docker/dockerfiles/alpine.docker               |  2 +-
>  tests/docker/dockerfiles/centos9.docker              |  2 +-
>  .../docker/dockerfiles/debian-all-test-cross.docker  | 10 ++++++----
>  tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian-i686-cross.docker    |  2 +-
>  .../docker/dockerfiles/debian-mips64el-cross.docker  |  2 +-
>  tests/docker/dockerfiles/debian-mipsel-cross.docker  |  2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 +-
>  tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 +-
>  tests/docker/dockerfiles/debian.docker               |  2 +-
>  tests/docker/dockerfiles/fedora-rust-nightly.docker  |  2 +-
>  tests/docker/dockerfiles/fedora-win64-cross.docker   |  2 +-
>  tests/docker/dockerfiles/fedora.docker               |  2 +-
>  tests/docker/dockerfiles/opensuse-leap.docker        |  2 +-
>  scripts/git.orderfile                                |  4 ++++
>  19 files changed, 33 insertions(+), 25 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

