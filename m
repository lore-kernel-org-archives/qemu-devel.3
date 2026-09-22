Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D454C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sH6-00059I-L6; Tue, 22 Sep 2026 00:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sH4-000592-Gc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:38:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sH2-0006X5-TV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:38:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M2sQbF3675297
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 71gyWYUPztH6lKna3HKYEYw1D7QgBGxBVV0gDLgS93I=; b=YBD2XPWYT6keIALZ
 N1m0g5D8fnBcADpUyjCbEEsm0rrSHDCZsXmOvtE90/5+sWHQsHC/JfHPPoc9PKpz
 zWh53ZJ9SkHL7ZBdh5Q6R1wyxT4hWgmoBYFkV51IwTkUEf62GzJxhxgIR4iqpF5B
 zUz6KruV6HNvSwbIiMVffU2cUY9VF1RxNlzOuOaD0YWbSgx8Ka2MFPU6986avzrp
 WaIWmojxaYWCUscOXD1aKgYSbKMrmcc/SQ8MTX0YASQfJNnUEath8HgpXzt1lOX8
 1VkYfRoBIi7hHtOuitzeBUNH8nyMb6r5v17g3lYQwyRBSRi8NZkfrX+rI8gusAkg
 JlKmXA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guha5raus-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:38:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93903622880so105330685a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790051910; x=1790656710; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=71gyWYUPztH6lKna3HKYEYw1D7QgBGxBVV0gDLgS93I=;
 b=IcEIfhUHMQH820GBnpdQ28F8Zdeze3Zj3cMwf6jq5zv42M8Kq18+9QCrIJ9+ZMw6Mm
 fmDc0aZ8ga+dEW9D7SR0cyseWwrexjcDj8excWAp9C7ahXDRxfcSieEokubEQx69h0aA
 NAThyuSG27hqQ5G5wrWdWOQ0dJUBuel6fSrMPGKH0F93ZQXatC4odMKT+ppcK9qxXgTI
 dy0eW/nDzZYp/xsWUY7kTjNvrdcBtxzMUuD1sTzZA0awsU7FBBvPA14Gvz9bGwdCd2qO
 dwNPBZFMOvkASisJWHTbYwZLcZcLKkFTYsPcVB/XSj6CBogfZn4jKr3pQl5zMJKq6mfU
 Ff+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790051910; x=1790656710;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=71gyWYUPztH6lKna3HKYEYw1D7QgBGxBVV0gDLgS93I=;
 b=1xXFuqWWihyUTyslpSpJSugahUsJ/QUriT79PC2ZKw4MvN+rUw8AaiCfXtB0lfDVxA
 D9bKYTtaRw35oD8BdCKM16d1+yrNbPt2RRbA4cIM+LVQnvNTmeRigO4b83P6zLS6SxLP
 aQFghyQSc5JOMyEcxvmWxSOOYqmwDwvjTfPAwoVszCNIlPQ8aAG7ZiNAJsjpcAqUjR33
 co58qS8Drri9ItrCINYvAcQzOf754SXWGX4yVMgntm3880EaMcrN9RXSvcldtYt9f8Zt
 RjaRHvuod9hqbgYjR1MZXi2zA6yXO1LgVkWAiF0Hc6gZBrRPlJasyoRhd9pOFZoEC3vn
 x5dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0AiDPAqgoxU5ZLxlVf0mYES4y9fuLzjFJSAE+4hUQyxLirsnlCIvT0RDsYq4DJ/ny1LaLH+iNZYqF@nongnu.org
X-Gm-Message-State: AFuF++kuy0A8QP09X+xDt906dA3FsBB+wla/UWXddHFCJ6fac1moeQX1
 /uaafiUmMLgIMW3dMxfy+2syfapeYNKK8sEHnDXd/genRzqlzcllHRav8CH2G6DtF8ipqomsgXI
 E5NgJWtramU2CNH1JZl95vykChNSA7ELrby99n8NGk6NLRljqGdJ9SL70sg==
X-Gm-Gg: AYBFou08kN18HwgEAHPjqyPWktpfFZBaCPRxbrGcbIPmvBWVdEnTHQ16l15KWog1BPV
 THGSGLymMnv2Oqvd3wlCf7GSTVY9RGybfrXPJkwCEzAo+IkENEf8d2QyF3lHWFW6q+q6YPtC5rx
 OfEstjyT5CArC59GQAaTq+SGpQQzvkso8BiurrUXrrX4fEzkorOyfYI9ppTmdJNnyZJXYqah1KY
 0OAMPd8V7f42Ch/Bb/IMBy3nHDnmnNGZMIMEAeoGXJ5VpW5nvVdJQGrcmNVrradjMh7PcSvrPDn
 HsQvzoMODoGKlCZsYf+SItY0dUmMYPmufXoBe3OF2AnyvXjii6OdL6CXZ438X41sLcMAESFgz84
 swIM8Xo6FABIL/c/J1Ig9wHrDeIWdxPgrPA==
X-Received: by 2002:a05:620a:1714:b0:939:cb6:997c with SMTP id
 af79cd13be357-93c17e3228amr269167085a.13.1790051910575; 
 Mon, 21 Sep 2026 21:38:30 -0700 (PDT)
X-Received: by 2002:a05:620a:1714:b0:939:cb6:997c with SMTP id
 af79cd13be357-93c17e3228amr269166285a.13.1790051910148; 
 Mon, 21 Sep 2026 21:38:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad53b53sm17348155e9.14.2026.09.21.21.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:38:28 -0700 (PDT)
Message-ID: <1c32d9fa-5c52-4b08-932b-3b9592a4c36c@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/xen: use stub_ss for xen_stubs
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>
References: <20260921204954.50529-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921204954.50529-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921204954.50529-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Sr1EaiFJMeQT7L2tkmcbUezhDdRnWOMt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MyBTYWx0ZWRfX6UhqYX5KMBb4
 bsR75aLwSx9Qv/V81rmNITMfiXeXYN/Sxj72SnUi/ibNKt4MTkKmHUfwb837ntOMU7ocmPbA0rw
 +Ns6TyB6Azhzq1MMJkP5QoctSPpD76g=
X-Authority-Analysis: v=2.4 cv=U+4Hnuru c=1 sm=1 tr=0 ts=6ab20647 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kD1aHXNoiUmW-fgF_RsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Sr1EaiFJMeQT7L2tkmcbUezhDdRnWOMt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MyBTYWx0ZWRfX9PNDKV6mrPpi
 YxB4if95jnyYMNTMtdo6gnnTzscg3us+joZbx/Bup6ptaBTydWllWT3MFD0b9F7ttMCKqhOrPis
 16legTucng1cu+EhquKMjGDzVROyEMIwaXrYurNIO+Q+5GHpI1lqnve0fjFKCOIcrCtAX980jsZ
 j2ZImjmod5JVeauiMMkDNmiY90mKlFkb6IqqqRqfJfXsY/UqeU7i9koxiW2NZwd+18gObnTmlQB
 Qch0D/1pNO8JgT7JJiPIPAd9smm3b2eG9IYPnMbaAuElC3nNV/RKSDCwOL6GOcpZGLNdgWszOY7
 0TWUOPf6vezeJqhukCEnuzxgqwvyXC3GjUqSVmQZe0DSzvJ2GFcmd7iEO06kIJi5I2FdRug1JEL
 WJiFlLDwTfZz4D26ArLuXaB6vsE45Tp6rWyYGyzdzVvE9fyD32Xnl7VDSJUiyiAV7A4T4OyFl++
 nHntdtBigsGoTLlyVkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220063
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

On 21/9/26 22:49, Pierrick Bouvier wrote:
> Solves these link errors on aarch64 hosts when linking
> arm and aarch64 targets:
> 
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_hvm_modified_memory':
> /qemu/build/../hw/xen/xen_stubs.c:17: multiple definition of `xen_hvm_modified_memory'; libsystem_arm.a.p/hw_arm_xen-stubs.c.o:/qemu/build/../hw/arm/xen-stubs.c:25: first defined here
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_ram_alloc':
> /qemu/build/../hw/xen/xen_stubs.c:23: multiple definition of `xen_ram_alloc'; libsystem.a.p/hw_xen_xen-hvm-common.c.o:/qemu/build/../hw/xen/xen-hvm-common.c:39: first defined here
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_mr_is_memory':
> /qemu/build/../hw/xen/xen_stubs.c:28: multiple definition of `xen_mr_is_memory'; libsystem.a.p/hw_xen_xen-hvm-common.c.o:/qemu/build/../hw/xen/xen-hvm-common.c:27: first defined here
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_map_cache_enabled':
> /qemu/build/../hw/xen/xen_stubs.c:34: multiple definition of `xen_map_cache_enabled'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:86: first defined here
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_invalidate_map_cache_entry':
> /qemu/build/../hw/xen/xen_stubs.c:38: multiple definition of `xen_invalidate_map_cache_entry'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:664: first defined here
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_ram_addr_from_mapcache':
> /qemu/build/../hw/xen/xen_stubs.c:43: multiple definition of `xen_ram_addr_from_mapcache'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:538: first defined here
> /usr/bin/ld: libsystem.a.p/hw_xen_xen_stubs.c.o: in function `xen_map_cache':
> /qemu/build/../hw/xen/xen_stubs.c:54: multiple definition of `xen_map_cache'; libsystem.a.p/hw_xen_xen-mapcache.c.o:/qemu/build/../hw/xen/xen-mapcache.c:468: first defined here
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/xen/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Missed in 2fa22ab7fe5 ("hw/*: Build stubs once") :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

