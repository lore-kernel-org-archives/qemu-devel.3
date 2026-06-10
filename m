Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35526CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNsc-0005XO-Nn; Wed, 10 Jun 2026 14:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNsX-0005Vp-Hl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:42:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXNsU-00056l-MD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:42:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFwjQQ1997262
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0dwlJhmiSCmZLkhAecpSpPA7G9RBm/W3Y5aeWg73jsc=; b=JXexkxWDl4UV/8Wd
 L1VipuWlGDlQ582K0qfHkO4tpQ89Uuvmun2ADvVd9Ki5r/42OVRaTs655aM7aDi2
 qvTNJ3gVjvILyHU1d3D0maaX+ShmAZCohcAxzWpkZb2SUNynpF5VAuQe/cgH7ezj
 oFZSjOSVN3rUiXtpetlB7rEylVafHzF7W6m8yWx0V2Y9XRcUFrfPM7Bz0YH0/CDr
 UusDY2lPiq7SdpgkXTzuE2PGrsGWsOFU+Cvo68Xg6NRWUd80PK/UzogxSdhbNHEJ
 Le6/VVbPyobO57q8te5HC0LOQUZtelEUdwiFnO9zAC1rOObWWUxrEBByY+snv/dD
 hVlcCg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kdbhsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:42:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30761ab3483so4165382eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781116930; x=1781721730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0dwlJhmiSCmZLkhAecpSpPA7G9RBm/W3Y5aeWg73jsc=;
 b=BYK8OnieZPEVfdAnHq0Wx2KTEG+PzdotSZcNrjc4n9eTJ+etVSgRMpNGp9tZ22mnZJ
 likLwwBXhZvhS/fZ5MW5n0RH1fMLwBi65pNpPStTvYCZgiyrumg0c4AUs9RPCEAfSWhl
 RBqo0YlrR/vdn/FfcHmXHWSXP+14BKTql+1HxZO98fQJWtYDlBRVc4ueb75PPiJzxI3x
 s7XX+D+YsZy+tRDQk49V16Gb2SjTNOH1LySkPeAZpnlzsqwjMvWh2AE6ccS3+LbKWEPT
 /auZGo+jihLqncWizihL8jeO8pRUVPLsS8k/lQVzOB8pOjWOgPRdNqyLDfeCwlYDG4TJ
 INhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781116930; x=1781721730;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dwlJhmiSCmZLkhAecpSpPA7G9RBm/W3Y5aeWg73jsc=;
 b=iOylQNNlGpl3WfE6f2aXQIjijb38ji6P+NjtFUCbD6+3z1Y29ZvDWJ+gDSuHOQNQ7t
 jc8L8DD6hNrfPqVLHnTlGGJuO369KZpMiPv2BgIqmBawpqIF8DrTzUQS6wq8pF4yM/13
 bM0TcGvDH1MBekCsSNl6uB69DQyglRj+KwCCBHHZ/YAox3nmtVfeWC2lvgZncoWoeTg/
 rsaLoB1rn5/jQs6ea8OwvTt/F8g3nR1kFDU0DNOeU0bwSpES8aVQ1z+9tOyFdPzM7DHj
 PabS4QY1UGjkoz4aebgg3lL0aXEecbTtxhVeJlq3FgmfysedHjWFKCAx6iAgKZOIf5kA
 m+4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yEemPX5ZwCLoz8S+iJagPqoTwJXtmH6GbEoC4j5mkBzwM488x2ykrCWiVnWQ30UZcbApZ18Z57gmC@nongnu.org
X-Gm-Message-State: AOJu0YwNbAs5j6lzzC3L/SZb53+O6hzPt4P5+/IlDJKx1teXWrsKC/+Q
 +MHTKq+hPYZmifV50BnORVg0TLjGztAVay2oACkTx8r1lWgEDDFQxxqtntkIBjKIu8JrORNjc9N
 eA7JEMejyS+5pksfc22j/C3p7Gfcw5zFtQ2yMZ4Bpof4X2pxHysQP+Jl73g==
X-Gm-Gg: Acq92OGdwtAhVuMAPTE6OEnyVBfC3J97JyGj798OlTBrHHK/3vZ3hu7Qufqh/C6r/pV
 vhoU/6PX8iU+zgy4gn9kvn4X/qH7eaMqnoNpyKEJWSrv1rIO5buFFxpLudBPoDSB7sGmJfXO5LV
 ut306nz9zEdVxB+UNoHmlInGsZP5oZE6GexOZQB/MBkP7qTtUWFc2zTUs5RzbDONyIWPAMLhkIa
 3nKSYlTs/uHd1OOm7SCuyeVgdqvU24uxHKlhjWKolDwA3jM6K4HedC1jlXtFUGN7vFtAnEPgGPh
 /S7/HE9dROqyqxFmdNOj5pVO10ary90vwpWbz0wofkEch6mcN7z5SOOREW1nC4WtqC0oFsYAmb6
 vK2lLUvVphTLE8xxhJbgc6kR7pZjTrl94V+rUkyxjjIFrPIud0ma/eYs4gp3RPlYTzagEQsOCha
 yWcB18SNb/Ahvje6wEg5s/7e4G
X-Received: by 2002:a05:7300:8c1b:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-307d62ddc82mr7309751eec.22.1781116930358; 
 Wed, 10 Jun 2026 11:42:10 -0700 (PDT)
X-Received: by 2002:a05:7300:8c1b:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-307d62ddc82mr7309722eec.22.1781116929874; 
 Wed, 10 Jun 2026 11:42:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30777ecf9e9sm21519058eec.28.2026.06.10.11.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:42:09 -0700 (PDT)
Message-ID: <740bec36-9e2b-4e29-8017-ccd087ef75b0@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 11:42:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/27] tests/tcg/meson.build: add wrapper run_with_input
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-19-pierrick.bouvier@oss.qualcomm.com>
 <tgenhk.1crggx28eg1me@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgenhk.1crggx28eg1me@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a29b004 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=xNf9USuDAAAA:8 a=EUspDBNiAAAA:8 a=qzEvNn_Qf1mMO3kGbkcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: XzMSz0LhGfadX6Vy5At5id9d_O-BkzEr
X-Proofpoint-ORIG-GUID: XzMSz0LhGfadX6Vy5At5id9d_O-BkzEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE3NiBTYWx0ZWRfX3JOPjkEnlQwy
 0iitaS1AHotfXhF9dgXgTmUCdzdd577Py/bq4l3Bu5om3prTynQC+WWPca8ITiqAiTZt/Q0Or4+
 UMFcXL74Sgr7J3WCmYxSKVmGaP4TCOkqygJ/SPBeqEkzHM51s8ENhZ08Dk++yDNdVTbNpxznLLS
 zSlLd/r/DAjJR5N65238QGPwXe3h8hI+0eDCDcjQFV5CWL4HS4pIv6gqhcxd8TvGQXhLvd302GP
 JUlGsowlOzGtHagJD4f3krBf79CGDqy3OdnzkFk7CkJSMOu2EGxIQOjS8QVGmwfM199TkW/Waip
 oIPa7i9JkSLFzZnd44IHR9exo4SyKJc0aRyhOsCEMdM1bPbFsihOkhQoAH66GUaUED3IaqimIgS
 Q3SuJXj4sYMyS3ch4FvD6mCZu7MQ+DKDciMiUr8rVsoeSpnyH108QLPQmVrEmLDyCARb8mMOfdR
 siCjA0HQ4wD7H2HK9Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100176
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/10/2026 12:28 AM, Manos Pitsidianakis wrote:
> On Wed, 10 Jun 2026 00:47, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> Semihosting console tests require console interaction, and were flagged
>> as manual because of this. This wrapper automates interaction, by
>> sending a specific string on stdin.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
> 
> Fyi there is also expect(1) https://packages.debian.org/trixie/expect
> but is kind of arcane.
>

An an additional dependency that may or may not be available also.
Also, this kind of interaction is more for functional test.
The goal here was just to automate a single test.

