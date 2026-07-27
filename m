Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C8C54EFC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woF1v-0008De-Bc; Mon, 27 Jul 2026 02:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woF1r-0008DA-7O
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:41:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woF1p-0001TO-OL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:41:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1g2MN2257280
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CLfTJ+AUmXoN1iLtFR3opWLp3SOwKPoN47tiw5eKqO4=; b=PCFChmy+O3NrZBtX
 IYEor4aOCsQL3emlVuVJkbKWXmfEIEFrtJQYa8PkREsiq8N2TNgL7gSdaH+B5pa/
 MVEv/cRTZ4bJuVRUDaY6c4oerwn9K8mH5KQDxxtjXhjItL0GP/ThbRrn19pIB7bI
 YxQZz5nabGdhUPJbR3mzAjyAHTlv8cxwGNTDFRJz/AuAtDtHQBHgbdTCd3Hde/kf
 4Ci4HlaSzdV3WykTdPStPd3Fo0iRQ6lMXnlk+bsfdoL6+lO2Us1Tm+Xde0qFuUGb
 /Yp+E70Pm68GkcDkByMxcMNxRCxETLsgTPIoXDVRokLELa1HuC1iVpJS1QYLLeML
 45EzoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmfgvxq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:41:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so36644201cf.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785134490; x=1785739290; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CLfTJ+AUmXoN1iLtFR3opWLp3SOwKPoN47tiw5eKqO4=;
 b=ONbl81Oa6e8O1G/mUaEcu2R+3SfrXxzZE4HCGQIpev5+G71nT1Pjjg9IvvbXjbf20W
 Dy7pd+6t7xCNJ8X8Pv6AyzUTptddRfNoYMDpIGRGzrc+icQLIgxQOEb3Ph7iu1go7/ek
 AI+wxoBhEHd7nLJsEbMdOVVPpzSEhPxi7jK+/Q9xgcwDcWa7Xm4VwvIwrGpq1iEYyod/
 Y/0GvTAYgs9tGs6rwTDQ9luhAOC1+iASyQI1l+fatFeAJsV4NK2tJ6ObY1XLZmVUZiXB
 epLGDwn/11JZ4fZJNYlQSFOosxGuCevESLjUG6wvtbMp6B3Z88o/RSeWNfIbyp1WLca/
 Gzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785134490; x=1785739290;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CLfTJ+AUmXoN1iLtFR3opWLp3SOwKPoN47tiw5eKqO4=;
 b=FYRSzj4fq/B8DyBo7Us1/6lKqaZZOKj6Y3XJUHIw1IpbmhbQhPg2IKlRRvwl+KwZ3O
 TJS2nKhKYNGvlnH8lGyFy4/C5iaMhyH7csaMjFR6hVz5QrHaRHLLU+9+4aaBbLPUG5Od
 3cGtyk30Ql7fspFwV47dTeR17OMGoRuAuQtp6hoAHYthCcbdiCx5Z+MEjw/CZZEz90bg
 0PM04CZR4ljQNdyOrteW6vksq5NmasDIGbOhX/8dp+TOXIpMfL4wg6IeIAzSLlPf3Mtn
 WgL1Yl6euTsS7X8ISTBcDIkRoCdu6O4uQL6Jtsc+ES+a9f35VsQlAFAqKv1q3PVUV8z0
 QWcw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy28oP5NW4Tr/pno5Dj+D2J3TJW8qYw81eBUN+siQJApeAD+/IPzX1GctvjBPddHzUI5qKdnl0GUJZ@nongnu.org
X-Gm-Message-State: AOJu0Yx8eNW/CeGSw0utzcigIoS++Y6LyGaXx3+A0dsMxs5K7C1Ty//Y
 n4j/Ws1WosIXZMl98RAj8lSHnP9sj34R/l+SOLINE4VA8QkXNV0ZX+aLs7nKW9ODSVJ7am3ea4p
 cqbJE5FQUe5dOxxC5y+k62GgJhEX9cKyvDZV1vUO/ura2X4TJgvbmrfUKJw==
X-Gm-Gg: AR+sD10NRxb92McXy0eoq0nz3QmBN9SnnNy3Sr1K3w02mbhO10S93r/5qymS7h53Pad
 U3BtntLIGo6uTCRyOz44GT8niiXP8P1oQyZvqzehW1kDtt9jYjdXpvJqVJg2FjWXajIZfaE5NB1
 lYdNIR92Kc5TOa//FJ2ZWeTHGEoIWVORa4KD7mrFx+RYLB8OR85+vblsiwCF5pV76oOtSivC96A
 EtDQAUID30IeA715KjhAMsjEGhi56kggfOF5DmG8/pUj6GsDHf7MdGY+X2UXlWBkLGEwBFy0XaF
 F/FDyM4EYN+zBhmetnniTdoy80ZUMB++vrdOjB1Jf30HsPMbsGSXZ7BBmZux8/sl8RsEBB/fP1O
 6J/HOHdFA3A2KpGWaDzWn3HCwrkBxYa07EX0fZ7HtPEAmk0rbAJI=
X-Received: by 2002:ac8:5844:0:b0:527:2b06:2bd1 with SMTP id
 d75a77b69052e-529a8715e81mr79406461cf.62.1785134489947; 
 Sun, 26 Jul 2026 23:41:29 -0700 (PDT)
X-Received: by 2002:ac8:5844:0:b0:527:2b06:2bd1 with SMTP id
 d75a77b69052e-529a8715e81mr79406181cf.62.1785134489563; 
 Sun, 26 Jul 2026 23:41:29 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f302f8sm192401725e9.12.2026.07.26.23.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:41:28 -0700 (PDT)
Message-ID: <f7e2f36c-265d-4fff-8fd6-31313daaef86@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/hexagon: fix machine->fdt leak in qom-test
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iigU_Nyso0EJkpf1YIP7v40XcL1Fe4vq
X-Proofpoint-ORIG-GUID: iigU_Nyso0EJkpf1YIP7v40XcL1Fe4vq
X-Authority-Analysis: v=2.4 cv=GdYnWwXL c=1 sm=1 tr=0 ts=6a66fd9a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=CN8BiiQClkPCgTBgyyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2NSBTYWx0ZWRfXzwsYY/E/1kFk
 IEHoP3aN578c70howdGMx4Pwiz2Q01tKpLrml/aX4G2Umy9+jCj7/1zZTebRcs7aUzqlE6S57LW
 97j9ylaKT5h8Fm7DUSSJFCAR6FA7SdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2NSBTYWx0ZWRfXxu/AgxeAmN4u
 de3T5L49VOp8LzCg10OjOuVDmrFUl58xTwE/i2YbsPlb4wRGd2fbamt9WU/cZTmxuL6MsVpdGhQ
 HLP8OBxEt9S/LXZivktZhSHPi9pr2lcpLE2AU/wUHDleoh+BxfsNu6qvZvbgS/Z0lq5S6mhB0g/
 0zagA+IQYMeCX/QE8ja7YXMvQUfQYXWmSuU4rrSsLL4SdS36rdsvqiC3zKedY/GhgNphfJ6wxZy
 8ADI/zTqZ5Ueva/ZWSJ/OG5lGD4c2rzmPfVr0PyikExbambgA9vMCWrPOCQaBubTppiMG0fti1X
 iWGTl8E7COemCTD8LqyJSkGE2tCZnTkzhCaamCYhPC9JdwQhuU/wR1oQebpbHDdjQ0/uiOg+KhP
 Ud/B8A4//P+uPogj4BsG2W5op1lEsmK1CHQvhnFxUGtjaHD897e7AZsrt8abwKMf7pQY/wfIY+n
 brj27zDvb1wntDq9now==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270065
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

On 25/7/26 16:00, Marc-AndrÃ© Lureau wrote:
> virt_instance_init() built the FDT unconditionally at QOM
> instance-init time, so simply instantiating the object (e.g. via
> qom-test's introspection, without ever realizing the machine) leaked
> the 1MB FDT blob: machine_finalize() does not free machine->fdt.
> 
> Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
> their MachineClass::init callback, which only runs when the machine
> is actually selected to boot. Do the same here by moving create_fdt()
> into virt_init().
> 
> Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/hexagon/virt.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

