Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A1CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLUW-0001gE-2C; Tue, 19 May 2026 10:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUU-0001fi-K8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUT-0004gu-1X
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:14 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JEHUEC1146715
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R62JCISRgCoe9z/Fb4OSIE7JhaMuLCN98xnnJvAx8vI=; b=EG3IaQawKgQ0RZsw
 p8JAumMh9Yj3XRP6A6JyZ+3oEh6VB9HxSWOaNd/9JPT9+j1MkL2SKdWiKYr8+qKO
 eBOYupAPWTMSjjKfMsqLr1xQn/NkzuSAoYEAUjqPcbqlGAl8AbJUURGscNjd0Cul
 ZfkVNxwwgKj6xWdP8Lqks14vxxW1cjfJEdPU0kmrIJmFqWZ3xDFUyRZ3Lo2QdF2y
 2AH+dM7BAnseRIvITb0jsWiIFjqiSAOhxaHvOWVqBHd+4yWhh23Tdloj16s4t0Wr
 B3xc2pnDVQh3TSZwP9mfoOmMKBWT4QfGUdmCXyAub3lUotfo6RXJVFqeELVrx8Je
 OVeUVA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ek07t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:11 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dba1e866dso2496165c88.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201131; x=1779805931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R62JCISRgCoe9z/Fb4OSIE7JhaMuLCN98xnnJvAx8vI=;
 b=XZsTufTS+AP2onaCfx+ROfQOq6SrBqNQGuIOaPqaikNwlEx4VIsJiuS7pXySEf5jO4
 Xap/sVNKYBojiCgGsoWL8vFDOoo9lP5l/0bs91WtErX7YBjXSNyKRDlx/ZfLR6aEM0SX
 Hnb/eq+Xv94NTBkDwx7PHU2+JvqAszjWXxJ1DQ1VKGN7zdd/Od6AGYTyF7T25O5XM3+A
 sLv8C18O1XKvabXpOraopHbhoPsergpUDDLlD9zLGYMFWs+I3DDhpOGj69wjZD+vTgTO
 Ja/gjxIqVg2Y2fh41kQdAV1NWGy/FZZi3P6ZgWSznUmoVeKvUAG0PXtYAkR6K3HqA5Rc
 Mtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201131; x=1779805931;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R62JCISRgCoe9z/Fb4OSIE7JhaMuLCN98xnnJvAx8vI=;
 b=YKouAZPKXfd49R50Rdz/3ETE5VWdWrxShDBEnTJvyRWAVz27inXZ1loRSfRJ9VYBDg
 9gqU088c2pY3LXBaJ71lPyiTGuA9IBjjxl/wz9qotwd8EUlTbi1QYd9vTO6UdyKq7FLi
 jyupxkKMsf36MPLoPc9UfhopCbqa4zQ8CbjmGfGCaCzJ/4KviK/hZTUno0LcOnmqDmbQ
 0k7k/nDvU/TIaItpDXmQrSivlGb8QLvqlR+cqlhb0bw4fAYUBNlkGSnO3pJOiopfT1sw
 NeAe14RonkmGLOMgw3w2xbleq68mCskL2jUYlHexKN4alEcDVM8g5/tawkIXVDeSh1Zj
 d8MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QD8awBo+b+Jb6kLXPYfRJeHvpXK7FpBJWFyTmWjoHbQSZ0Et6zgEcXJUh/e+KbR2aXt/mcKtV/W4+@nongnu.org
X-Gm-Message-State: AOJu0Yy/H3eAUCj8fOOCA+XStHgrmhT29IM2Gday9iB3g5Z2va4mauA4
 f8ilMUABRCW/4JbIpQ+UUo8gGfBvV/rFj3UtOqC5Vd8dpFOpYbmqXwaHv7zVpLe293CDYSjWqT4
 ogixPHUzWLdvLdRnX3Wndz374HI1KtgbY6v1jK+n8spQZHc9Cv+RPQ7+RsA==
X-Gm-Gg: Acq92OEMJoS6EtLffVDVhiG4ScPzd9CAWUs4QxunIfm6/jQU1Iaw1VgwsGEC1Ss9mBQ
 ZbHrEmMntLfpg0tz+52oz7CDYMBlIqIaAkMV7qerZdDxgeZlS+JAKut1KmUjGqaMyzz5YHorMKt
 nZl+exYCzr3I6mhfxqNUDHc/FqvMPfNacGfeHCBHD03e5U39dZsBRHMupbrSxuFVmq0yPjZ+h0T
 FNiy43NKJpn7E439Wth8p1M+Fl1GxA+qS7KNDw+8khgX/BIrAWGm2A+UAHoBnNtiuT3N5E6OfSp
 TpRkuDThKgk2RK7PMX0jWH1gK92b5yFc5MWCPxrbtHDROWylEJCnL2PfxGw6f+UfD+7TbwCn1kS
 wpUYvM4oK1IFP+rdIiAPAfeZAwcVq/tkSevrpPziT4viYH+cTFG9PgDw=
X-Received: by 2002:a05:7022:f8c:b0:12c:aae:7b43 with SMTP id
 a92af1059eb24-134c8d4f504mr10005429c88.24.1779201130716; 
 Tue, 19 May 2026 07:32:10 -0700 (PDT)
X-Received: by 2002:a05:7022:f8c:b0:12c:aae:7b43 with SMTP id
 a92af1059eb24-134c8d4f504mr10005397c88.24.1779201130192; 
 Tue, 19 May 2026 07:32:10 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc464sm17370488eec.14.2026.05.19.07.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:32:09 -0700 (PDT)
Message-ID: <9bd6313e-f852-47d1-be02-afb39c8366a5@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:32:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] MAINTAINERS: Cover debian-xtensa-cross.docker with
 Xtensa section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c746b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hrFEmtGTxZFoBoM5y9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OtGS-68oIGAA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VAdzU8YuM1j0HLKMh0oFJ1FroHkmmjg1
X-Proofpoint-GUID: VAdzU8YuM1j0HLKMh0oFJ1FroHkmmjg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfX9ccjOUAFNlNm
 7CQZHYfvksIaegbkMdT9FtyQfGiaqZw+imO2M6N41ug472hmuNwUYI8JYMQL21WJWYzuZYUF01v
 LJ8Z+/Qa/n9pLySdS/E+KQHZpA1eZN7iRBF1Sb8QojPjmmzfFRsIESkAJnopMXbJdkuwhrwzGl1
 w7wFqmw2TtiWHlkQHDLMqrth5p41pOKEKQgLGgKSVNFjaGm/5Fa8c4WtiM5Epa8wObXgkv/bZaQ
 Wyvxh7u5xmI+AQr6Ee7w6BSJO12iK/XLKIJ09ATdnoQmRGSjb2FmhdF1xxbcElYHkxGWUyGE9JH
 CMvU+VbFTXmhFOlkiJkbQ28aPoDwFQuajvhbtk37iXWMm22VyzMYHfXz9ZGvUTKndYegSZH4ILw
 mFF/Opm/hsI1Dmw0tuExKSn77c71Bz4xN8h3ir9zjMkgRlNPkv5RZyRfQOkKHup0hH6ZfTi+0KE
 ekoXJqfsbG6ew2GHYWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190143
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

