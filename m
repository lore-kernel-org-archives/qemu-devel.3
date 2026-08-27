Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75419C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVg8-0001nD-Ut; Thu, 27 Aug 2026 04:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVg7-0001mp-Kq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:41:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVg5-0006kB-Ru
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:41:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R8ql087754
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SmOBVBiGsHolNU8PiQp4XF/NOueJObjNbn6UN13+F2g=; b=J55oBVw/f35P30EL
 IC+gIz26L1ZloGtBz+LikeppJmtlnBeFHIVmTX7OqeX7oVs7+EavvEhRD+7EoiKB
 YxYBxrgxeF5bcAET5foJEf6+9z2+u0oRTUkjWVf2nm0Cjfz7daYiEgjoME5VoCzA
 riNRXYxQ/RW5lLj1iY57mfJWbF6Jsivz2NA9BI0AYu0Yaygn2mUsP2Gxd+ZtJ/K+
 JGo2nFl/SRmp4P7fMSKDcB+G1ehtaKU0ndRoAjo0T0ch71GajPNlCOqnPfJ6rNfu
 XA/hRGdPW9UkhctDS7OTrKcmS/V49GzAbws4bdBTDczcrYiFbvgPZi9l6EGa6o43
 Vz92kg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hvb0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:41:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ef04756caso13344151cf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820099; x=1788424899; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SmOBVBiGsHolNU8PiQp4XF/NOueJObjNbn6UN13+F2g=;
 b=Zv2c37GbM7EVM2G9JJSL5QBSS3IhU7e9vlQq9iNTUw1qTtiw+78+puZyc1ZnUO9IOj
 iNaHLhiOFTzWmBV1hCsxti/mEvhopY78AKuHO5FXAFn2OGrYxm0q+mn8LVFkOLgp+OgJ
 QvLVnZkEw7Ry02RMD6S9wQ+U4ib+DsG2+WOU6QAcHD+dgDECnZySBqRl/KDDGmJ0/ibD
 CC7hPU6MgUqpAKfmfxDEiMUl0yS6OImFa0ugJtT8YR02nWhQ747kSlopKDsNzm9qI92r
 bAOQ2McjN5RYozOW5B+Aq6GBPoxOaXG1CO+VOxSEWLK8VXAVMIaHIeSYL3+vzW542Fgl
 lNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820099; x=1788424899;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmOBVBiGsHolNU8PiQp4XF/NOueJObjNbn6UN13+F2g=;
 b=GHlioo5NJqB1ZNKp6jLzTr6vcELGtZ4vmH2MTGAHTP4amo0tTuBBcHZaZtGe5x1DY5
 woehF8wo0HkstqmZOL7cBDGBS0KRfN7jnvVWhpwl8vpCwGvQ4s19TPSe9GzOP1JG0voJ
 pOMHufzQ/40qY+WuBvaKkYyV2kgkNjavj0QAuHB5DXB1+KfhmjwaDXBhIk5CH+/sEvNJ
 sZg+MGaaz/a7pAFnEFAkzMhOnz8dPrDnzA5+22YT0ZN9EFeKb3hm4XnfsbdsPUyjpMft
 ZV5ugy3H5QdmzR3Z+8iEx7HyKB+mrd7BMjUaGk4dzPIct12xgKZ23a71qXz++4IWOVuN
 bFQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RriOk8tcY7Pk6DIhsRaIXFEg7amMNcPof0KExr7ltZZpLqcIdUCBTzZZOwWHWDrBBiJQvXXk3KwdOFC@nongnu.org
X-Gm-Message-State: AFuF++mDOc/YRtSsOlVdpZliKwG9ee+K+jscTu4molaywEpC4BIENuBb
 nWnE3MVauGeAhIyu3gss6MIL8yJVoeZsnTr4OIxzqj4D5AkQAr8KQa3clOEL5yq7uT8JFppqgcU
 0Be2DjorbYMgdGbETJQ8dlw3CxRX9D9WsD04AJAfc/HUCGBQul+PVsIEX5A==
X-Gm-Gg: AR+sD10qi1WEuJlRdeC6jzW86XSfOONd1jLk3YzTzG0XExxrM5S6VD4eoMeob3Bgr9p
 /y1YItxIqkUds64gtlBS9bzzC97R+romxyxA8yLKXAtL0etKhivS2ySomBGTk2VP4t/w0K0L3qe
 DKG/mvcTm4+FIvyb9zFWqJSI4RxwSTt26qy1IhUxezEUfU/e9xMuZF52vfuXu7t0i7QdGuw/Jdk
 IZwwLi1KRtmb6Hr1KGIiEgPpqWpdwJpn7fZ01ZTQiE05VYBQBKkj/k0lxRZHwK5w3NceEIRS5TO
 HdtK6jaGFnT67xFQ5ELKvuBTbYDou1dcCmKgV9AfdsihoUistFJq3t2MkEvzJMwoVCzscvFms01
 U8yUN2ySZalTncfznPUTkOMJK80fazkhXxFLHyA4LPuUBw+KT
X-Received: by 2002:a05:622a:1914:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52e4234e4c1mr140037041cf.29.1787820099529; 
 Thu, 27 Aug 2026 01:41:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1914:b0:51c:22c5:daee with SMTP id
 d75a77b69052e-52e4234e4c1mr140036341cf.29.1787820099116; 
 Thu, 27 Aug 2026 01:41:39 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm83255455e9.6.2026.08.27.01.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:41:38 -0700 (PDT)
Message-ID: <693accd8-abe2-4cde-ba61-0a33adb4c7ff@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/43] qapi: convert trivial intro sections for
 run-state.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-36-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-36-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OKiaIApPoGWo0OhdhdgdAEdMQd0PeTSS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX/o5OPQ19Oz9+
 6nygU0LkCcZCd+UAG+bPkGeLEJqs2WILPoJTHt5WaXJtjcWs1a4naZWub642LRitKcrYsSqPZAC
 /CkVfEBJqUlwHCaYMde6BwhqqZHu89w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX0stZqQrfiGyh
 1/wfPhMRmw4NhsFoF2dANAELhHSXH0ZaaUeCQtnqpg5BDcKX3HhljSg1umXudgO3W8IOSXmI6DP
 KEo4rtZM19DsiOHsiHa8nCXAZccI899EEg1lhjIgc0SAn/HgcLu9Ou6XfhNyok8t97JaXj5Xfz9
 DvfsnBO4ni4W5zTtFT4Zuct0vn2NWJagyKN+c/n/8ebe93JvHsjxib0NiWlwB1NXdKnuExKJZaU
 GZKwCGPU0Eqqmduic6T7ck720Rz/AwE82nRXnARyPwLNkNE8Yt/ccrgFu1qps6mUnWjqPMSHCUE
 jveccWEAzBrLJLX5zDD4rYGdrK4uUgb0GysOgWzDiTaCgDBYfWn4Y8Q25NzHJFFWBGZyeq/NMIU
 t03gYVA9q+TJ05afyDg0FcFh9J1wYIU5F0AoiZOHtjYbggbWVHonWs9AjwKzSkbiTzYZ5lZOX6u
 nq6RlF9JSfioL9Y5+Aw==
X-Proofpoint-GUID: OKiaIApPoGWo0OhdhdgdAEdMQd0PeTSS
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff844 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/run-state.json | 113 ++++++++++++++++----------------------------
>   1 file changed, 42 insertions(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

