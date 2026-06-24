Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97963CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNML-0002At-Sa; Wed, 24 Jun 2026 09:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcNMK-0002Ah-Ra
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:09:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcNMI-0001tf-Sd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:09:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANWnO3069789
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 13:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rr84W34NWGZ4znxcDeOfwqn+qFsWSVAB6n5oBVdn1dM=; b=eO+/TdFHVxexIXL1
 N4A+vwsoSEglLP+fX1oGFpXC/QSypvwIZ8lf/hswmhfYXMEPj93Y/5iF1reh32+d
 k4tklB/8LnCMv7chfwC5xa2iA2zONORDVtP4f5vKD+LGXKAv0Wzvls4O+DdnM9Gd
 iCKaV857EU2ks9P1uHeTmQqYkj77fkle55F7x92PcmQawhI9HianVQoaiP+s/n7H
 Hr7giVvoDVjWRrZBKTagFqINdoMxDGVrwjhxEFHg6UwbR9b7/VGMp9eaqSbFp59s
 DKypKEskuWeiXOtsqY/2cWpn4nC5qC1sJmcp2ezvqBLzBGqs+UWdsZNBfXkSd8Ry
 8XJhCQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d5g0nw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 13:09:35 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4893fc86bebso1550149b6e.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782306575; x=1782911375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rr84W34NWGZ4znxcDeOfwqn+qFsWSVAB6n5oBVdn1dM=;
 b=CbswyIQUFN7Qv347Yi4wsm52g/2nNW/pXhBI4hkhkffzaOwVz5LXIasHdfazfA3J09
 z8Mh8OA9H/zT2ya+WYsKEJ3/x7+xdiRSf6iZ7xTyuP5qkMshOytmqepi2ptHvLrmehad
 njuX0t/vomePfVsdq4h+K6+A/mMWEiXwUfd9wsXX/DcstIAguPYqawAw+QOiddhP7jmI
 UXfGX9YYxJcvzM1WfyaShazsipfj5jqqRmRwniPgxOtsGUB316j3/pmyScrbfwpvxd9Z
 mcO4SBi4cPmyXCz5eAwhqc6zaiZjrk6AY8MJ5hzDbUBILJl8bqeEV18ebv3huUTkvE8l
 hzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782306575; x=1782911375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rr84W34NWGZ4znxcDeOfwqn+qFsWSVAB6n5oBVdn1dM=;
 b=RfFV/9HDLV5yGHMYTzt3lqM3ivSPhzdXtLKeJeZOhGcJzsMZDk2yygAQg8JvpPMIhy
 lVxajP/OW1PVX+N4ImaViP46G9cZH1FUsBkY8zxteO+wy6cRghGuLdl3I12ZZ+Et+axf
 UXfRjPxAfUGngHeDoPgREW5pJ1QUgNbS0yz5pbmXHvWMxfV4Q7HqrHGZvkoQngHKQj8e
 Hodc5B911Z/xa7D4wvB6MLnvdi025MfgdTV9DiA6Ne1La6ssrHsLaxqiqdLnI3FIt8i7
 vss4/b0GwKhaBvikuuXSjYQkk1D8SyAQU/h7GE+gjc6KnN+euvKvNjuJhGq5Ivh+3xTh
 /siQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tYcQlLdTFui57lXy0B5LLmXPYDxiXDg11gdtkPgCg7c8/2hCEroRP/EQgBVBhVVfnoNIgv4XsHT91@nongnu.org
X-Gm-Message-State: AOJu0YxtdxqVc/GFXkW7oW/YVgpHrTqomH1ocGiE3cbspfDqOlVOa1Bw
 lXCx3/RNsG5BokIm3jIGL1KVMB0TkXHEWroyn3x9QCLntvtvtgrUvXM2xVzBZxpnMfk5PW0atHk
 OANIfpBaPGf7IcqcOLStdF+DCDfqU/rDEgwlfpqflk1+xtknOp6Z+lPTOng==
X-Gm-Gg: AfdE7cmYXsL5PSpBLJwcVmcIl75lw3Xk2MS7GWmKz2umqH6yDdWvFaQvmdTU+7KVtVK
 jl9oUvG3TPCm/ySrgtOnSkUQ312hoz4MFoi7DQIH+4Sk5G4xjE9vln+80/rAob6GDaEXSCsv2Ho
 6uCZQTvroWBb8eAXZveeL+id3Px7NJv7wwDKtgUYPwqV2DVFRf0yie39CiP6L7TBorFJ3SMGfDv
 FA2pNqeez20mFV6WbXoqlD0Hvelybqi3tuFzz2ZrbQt7qEO1wplj3tFm5fDxO90csEFbBUhDha7
 wgyrDkIy6eudrYWfMrs6kib2UyMQNFRzPm/kZTGX2UP+ao/Kjob1El/AuA3k7ZEbDFGbBoXq28k
 CjqBpd/6rQORQMHnqaOvVN6j7fsoq83sLJHz0VJw52Gw2BjA1CwDnC5ay6cMVnA==
X-Received: by 2002:a05:6808:1a25:b0:487:55d8:ec22 with SMTP id
 5614622812f47-4907818d7b0mr2017761b6e.1.1782306574926; 
 Wed, 24 Jun 2026 06:09:34 -0700 (PDT)
X-Received: by 2002:a05:6808:1a25:b0:487:55d8:ec22 with SMTP id
 5614622812f47-4907818d7b0mr2017730b6e.1.1782306574477; 
 Wed, 24 Jun 2026 06:09:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f49d73fdsm1097366a12.22.2026.06.24.06.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 06:09:33 -0700 (PDT)
Message-ID: <e950ef17-1316-4581-8f36-0674516ce471@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] gitlab: introduce files mapping GitLab accounts to
 real names
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260624122936.2706393-1-berrange@redhat.com>
 <20260624122936.2706393-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624122936.2706393-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdMMLDfi c=1 sm=1 tr=0 ts=6a3bd70f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=IFbzoKzz5nuzO0_TNRMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: H6AoJFMN3K59jrgRFx8ARSES8oxJFCLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwOSBTYWx0ZWRfX7FuZpowDPOJx
 yNw6TJKYLbIpgL862JRpaTd36bq2Pw4Rd+55Eq0P+TFT66tvRsKCzYze8xMqok2RDmDirf1vdM8
 LCY/WZXu+kN2BBrst40SRoZELPvQAAbj9elyfxK7AeuT+0CuPQXlILhE/FYlDdcUGupluMz+/QD
 dFo0nRKh8NjKJyvs1b9wnYx/Ate+DDYRu/6EALMMWpjxJb00Zx66qCJq7uiUfqgAQD8VozBlB8A
 MUdwbnd15HjWrCkgwILPLY4P51EygNrXFY3IRKdDtpKsBs3Ym30R5yxkoG3HU/PpmFGV0tAkp08
 HbWmHz+Zi1Rc0AiiEhsm/yfyKW+bCjHJL6jy+SYeT7EFp/kE+EIDH1ShqUmsBE+HIEfr9PvXIpb
 iGhJ9mqTiI7YLOdBVgGFrw5/tHh4/w==
X-Proofpoint-GUID: H6AoJFMN3K59jrgRFx8ARSES8oxJFCLf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwOSBTYWx0ZWRfX+od1VpVzUa+T
 tnBlRnFcVPbZ988DBiz2TAoFNb5lZ9/HZCgl4+FztdyUIg/GhMkm9mj7k2dbliwyloy0JCFXr27
 BNwq0XZceQnWjGe2Um+zZCyQAsvy9SM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240109
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

On 24/6/26 14:29, Daniel P. BerrangÃ© wrote:
> It is desirable to be able to discover the GitLab account handle
> assocaited with a real name in the MAINTAINERS file.
> 
> Rather that duplicating the same account handle multiple times,
> inline with the MAINTAINERS file entries, this introduces mapping
> files:
> 
>    * .gitlab-map-auto - data automatically queried from GitLab
>      using the 'glab' tool and REST API
>    * .gitlab-map-manual - manual overrides/augmentation for
>      cases where the MAINTAINERS real name does not match the
>      GitLab account real name

Thanks, much simpler to maintain!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> The former would need refreshing when we add new MAINTAINERS
> entries, if the person had to be added as a GitLab account
> member. For this purpose scripts/gitlab-map-update can be
> used, assuming the user has the 'glab' client tool present
> and configured with an access token.
> 
> To audit how many maintainers have GitLab handles present/missing
> scripts/gitlab-map-check can run a report.
> 
>    $ ./scripts/gitlab-map-check
>    Missing GitLab handle: Akihiko Odaki
>    Missing GitLab handle: Albert Esteve
>    ....
>    Missing GitLab handle: Zhenzhong Duan
>    Missing GitLab handle: Zhuoying Cai
>    GitLab handles missing: 161 / present: 57
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-map-auto          | 83 +++++++++++++++++++++++++++++++++++++++
>   .gitlab-map-manual        | 18 +++++++++
>   scripts/gitlab-map-check  | 23 +++++++++++
>   scripts/gitlab-map-update | 44 +++++++++++++++++++++
>   4 files changed, 168 insertions(+)
>   create mode 100644 .gitlab-map-auto
>   create mode 100644 .gitlab-map-manual
>   create mode 100755 scripts/gitlab-map-check
>   create mode 100755 scripts/gitlab-map-update


