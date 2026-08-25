Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578E8C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyw1-00017t-7Q; Tue, 25 Aug 2026 17:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyyw0-00017Y-0j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:43:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyyvy-0005w3-MG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:43:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9jik2991337
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BaHUK6yAWdTdslBGltT69fzpdeppwj38aoy8YdCvjKc=; b=n3p8SZa/72s051E9
 TEKCBlnrHgapCsXOaJzSYc/lVdOn0SUJdZ78otqt3CJ9N3qlMPcq93oLPG8PShQI
 Nfzad00zusvzRPIcWH4Ez6DoV2d8lOTHl+DC9g30O7yMTkumugS+0bhf2+RB9u1w
 09/LsOE9K2pnE0S40XNwI2H9chI8vuHL9T9IPg0LgEXOZuH9s0byUNzcBA5JvAn6
 87e1yT5Cge+pvMEKrAZ4DWfk/qrVsP/N2wNJTtMZV6BHyfUsM1NwI7uW+sB5Ujct
 ggs2qggRBD98hQsU+gH7bREV6YdG2EWk9yQ8wEP9FE91tsjKiNXyhKy0EMOG39ai
 2UgGSA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9cgpsreh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:43:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so3243911cf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787694232; x=1788299032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BaHUK6yAWdTdslBGltT69fzpdeppwj38aoy8YdCvjKc=;
 b=Lou2YZnXCBIo24C9GQ24haiu3m+ur90NbxCjSM8TyOptxgTsEYpowkV0e49RaQPEOw
 3A94xYwN5nti7Rr/SWl0u2Iv4UENCwUqb4BliLnnTax/MJcvar57ZOW2ieZEMmavdRQU
 8vwYs2sXv9x1awFn4SKX6Vot5oSRvrugxlpn2GJyzpEXwpOgGFvdcJXkxj2gV1o1RHC2
 ocZiE6vjx5XYjVF5G/izjpIu58JFBEMbfFe/Zue5u0D+ne5y2l1n2oMft7PNkZS+xZ+M
 AwpAEUYAFecf5nIuScFeVy7X67AZkoiQ3mbgOOHPaWmJ4Vx8cLRxTvNyr7VmuxzRDPYy
 HbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694232; x=1788299032;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BaHUK6yAWdTdslBGltT69fzpdeppwj38aoy8YdCvjKc=;
 b=Y0dAZUagVxchqmMsUwemOnxYXNxTrkVDvq51QHM3zb2OZ9w24JgKpL/Mwy7q9NHX3B
 pflIBz9F+q/r3UfObcLr6J8T/GpFZXbimGCdYimmsh5jy95QjcaqZuwTOk1HgR9peuNM
 sQxZyqYiNfzmqEZqSH7O3e+XtD6N/Q2nPBk+uhK5KFGaoW+H0XLY40xiLd1GpysUpajE
 GBCswgpEPI7DsVtRrjVjTQxXAk54Y64VgacWHFnK53PpYiUyL5AnMTyGM6YmdendJWbT
 M4NXnMynybv4O32TFjliuN3+M3anNkqo9WbZ6WGHxYOu7GGcGQM5A8jyiA6dLbpEzva2
 vAyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1x8BRlkPcePGly+C+hexsjpdqIc4g88tmGH7iZ1c9GSHZdT8Xv2kM3gFW5nllGtvnGsVuWYVdFBSQ@nongnu.org
X-Gm-Message-State: AFuF++m31jCDTKnw9TWwI/QkahLbJMYy6W3aj/LgUhHa6t25/F+KQqC7
 rCgDq50+Y04UjfWOiy+dUoGk7h7cJ3WhvmaoCx5eA7CbDgrw5nggKjA7ki7fdvqBchMh/45ifNG
 psifNR1QfjeiNPkj08JGreYROy0CrFay3esY2E/JGo1c+AP/cvu3527CW6w==
X-Gm-Gg: AR+sD10HiMJNG+3SJ4BIhpb5ClkcEPlkvKuLBbsPJxkOsOALH6xXlAYuNWLoyC/5MHU
 0p0UXxvSaPnXwpq1VNJb8tihI4+Ak5SURqWmRrT/Chlxw+zBy6TnJ7BcRExIe+uAN9TrEVXtgO+
 KuCEqV5S3rmHnukAiV+YVgltOepA8bAPjIZHYrO1kMQgX1V1UJ1O8fmvsyuLN7uFOJpY8cSe6dF
 NyPVDKw/D+WkRvvj3WCpGWqEzIcR7C3dZPnfbn3bQu1CPmlwTQxGxCr6WCPlZ1GscqX56lhwg1n
 URzpSF6IJ/cfZuiCF9Z7e+Z2TsJTqItE/Ksj3KmVU6OdomP/HsT//iY0bMl9VtcYFiaLRXm8Htv
 u0wA1ITz+wbC8va/0oIynH4kzqGsf5cCJ6wny8HAOV5TZx01MSa0=
X-Received: by 2002:a05:622a:1111:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52e42235670mr21717921cf.7.1787694232524; 
 Tue, 25 Aug 2026 14:43:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1111:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52e42235670mr21717621cf.7.1787694232116; 
 Tue, 25 Aug 2026 14:43:52 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e279ecaesm720531f8f.6.2026.08.25.14.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:43:51 -0700 (PDT)
Message-ID: <6c640370-225f-4438-a173-86510f37325c@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 49/49] gitlab: --disable-hmp in build-without-defaults
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-49-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-49-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NyZz6R4ZzDI1_ERK1DFEWoa_vBdC5Ezm
X-Proofpoint-ORIG-GUID: NyZz6R4ZzDI1_ERK1DFEWoa_vBdC5Ezm
X-Authority-Analysis: v=2.4 cv=I+NVgtgg c=1 sm=1 tr=0 ts=6a8e0c99 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX3wWus17HPRIg
 fUI8LhdHPNDHeIY2OoYsYgi0KT3t5P184YKlHsQpL5eHO2vANKPSeD8WCBRFOXcLWSNSYl89yqd
 oAl4BESqRHLh0UNnMB5NZVMfAdWcumAXGAKzBK7WlDkyqPem+GXaXy11IScGXpUPJqa3w2mgk5L
 XMlX6mWdLQZMIRXu8wt7+KjrewQfpNK2msbeybPSe+dsTreH0hkuL2wUgY0HmAPy32wSZaLNmln
 yN8xFQcSpf8GO/pz2/c36NwJWOYAziCyMapznePauiiehN/S1qOKHp2qp/PjlfESBLyIiGEWOZh
 29hWzoK7Q4lQb6fCYCuvi63rRVBDovI9siMH/xmgVS3RlREvF3r0e44/d289jcnRPZvCFDYDiUv
 NsnHM01Oifw2yO7AbhbpxlKpNrHkTbyM5KFz8cCQ3Lcu3vXFD2UTDF+FkjVjtPpE3H8xCL5ncJd
 w5l4NjX+kce/6hCRI6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX9xCmkeLrC39e
 dcZ/oIqRPRHDCvWOVhoJp0ktreA9VTymDXqu7owqbSnQe09tcfkuDHhQhwKaf4PQsKghYz6ZEyK
 yYmdA7bnw3zhJI6Y39eRQoKTG1yu+uM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

