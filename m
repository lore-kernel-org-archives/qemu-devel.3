Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428DC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAj6W-0006PP-NB; Sun, 27 Sep 2026 03:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj6F-0006K2-VW
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:15:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj6E-0002L4-6U
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:15:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxUaD4013981
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gNbdb1a4Eg8TqvqZT/jMuFZkviLnqSojNkYplKDccnk=; b=ECrsWkWwKsQpaHJK
 +2Vo8GTrjf2VcpSXouK86c33HLbZTXTZq0bd7gI9+vu8FZUAMrcGow9pVssg5fnG
 Je/mvyR+zncwTyMk1tCBOx6NwMex+vCNM8m9smxIgQ/CIdWqnX86pNwIJtQcXfou
 u+quDHT2hWuM+eYtqkmjMleLob0PJxAheCV6xocG/uXD7mg+NNRcMgI1ljNmqFX8
 rArtNhkEs61dtHjHo4nfA6xzXhkN8Ay7LruuYlVlRgG2P/VGFQppB9ZDEhc0PDAv
 IbZ3D/t9EDZW19HvozOcsj0HHw4wiH8XkgvZQb5opsKjVWiGCnu1YtLHSqRAOqxv
 ZOU71g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tejd1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:15:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a183a0e93so468904285a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790493299; x=1791098099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gNbdb1a4Eg8TqvqZT/jMuFZkviLnqSojNkYplKDccnk=;
 b=ibC4G2Vs8eWnWlUXgi6D6JflrYCrF/kmGpoZ+WdT2BjfqHh9Su0RSM2wYffAchi2q2
 zbci/X4hmhFG5cG8piXHTco69pYEL9SzxeHNWpj2GEnHqic1xhELKmcj4/MOEdGzlWZh
 6T4mtWO2SJE3V45BFD7I2B8eXpoiOAhdTuwuc0LMNWDsGO++1DmVTThuAApDXIkJFh3M
 U1bSgWXYPJL64L86Tmxmksr782+o1NvdL59WXqgmQEbbWOZ6B8deJLzXm4Z6F5WPzqAq
 zfrNzTXf8n2ROG2R0yhRwhvrzVZi/3bnF7aCR9ggvWMeDYUPf5ZM58uOh1wCw8HMj7v0
 k5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790493299; x=1791098099;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gNbdb1a4Eg8TqvqZT/jMuFZkviLnqSojNkYplKDccnk=;
 b=H1xB9u3+CB42mthDyC5WxhYJu7sQtf7mGw2m6WBFzdX3/B4FEXUXg+Pj/ToR87nCDO
 04bBg6eh93I3byQSo6jjFSNrzEGNUHeYMVZE0i3sa7nVsFAiG84UAzBcPK8Yhgd4kMrb
 ku5LqCnW20xyVDVZ9Kk30spsMNwwHBeQVQCYK/tcJLow948GfZuaKLT/u0mdqWS+NTX0
 Rkn1/jQMuJDB9Lk2zAegEuGHI5/N7uqu6pKAYSxu3eZQ0qcoFGzTlqeC3Hb58oI8tuLC
 xu2vlmrqQfow5b5zlFW2ihBhKQysGpgjSQNwanurHGFHLKxztPYvVUsxijNO2RrhDvFH
 KWag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwenK9C646FuiZQles/+ERAMFlxhPQcFGmZgej4iJOQYv4h4XJmolrYJPYSB+GRBwnBwu3RlvDumnKG@nongnu.org
X-Gm-Message-State: AFuF++m2LWfKFe0pewt2ckbru5ZAWGkB82/UMCJvv6adJ33cp/cd4hnW
 g8DfRCTvas91/IcmXGBBAxGSds8+RZPDVAunpK5KSFPf+VzWr5nKi+4N3sDaSFbi+qxnM4FP8gl
 fqUFtiRe+s2Ldi1pORObe2lXHMIaKZZEferM7hDbeP4Hfgq7SYX7wgjvXvw==
X-Gm-Gg: AYBFou2xRyz4bOUZ6o1EOWF2FThwcYGfxGvTGsWBnRAzzv+LqLn/DbWsGqXFIcmixi8
 Ye4lygri4W4FfWp6kBdX4U+t6RgMxp+OegBhMghz5SB6msttaHVDoFpQKJYE0nDRCf5RPGRoRde
 sVus6Xk0CPZxUwuDTK9546lRUCCALRTyxtxRsryP07JwDpe/aTiAuniNS+7VYfcHbHjqpQ8Ub86
 wTSJ3cwispqyNMtzurI5fksp7QQ5Op2jYF/9Hfozse0hEvGylp72Li1aqjU1D94qtoAk8dAILZy
 zoWgGsj/7CAzfC6oUAM/g0JSidct+OKSSBvSX/J7tgyBB3Bbf5I10mcSSznOYdM0IX/8/EtZTui
 rFTAWqVdhJhSEp3c7xfPBX31NJubliv9h9Q==
X-Received: by 2002:a05:620a:471f:b0:93b:d7a3:45d5 with SMTP id
 af79cd13be357-93c43d77939mr1393046085a.62.1790493299090; 
 Sun, 27 Sep 2026 00:14:59 -0700 (PDT)
X-Received: by 2002:a05:620a:471f:b0:93b:d7a3:45d5 with SMTP id
 af79cd13be357-93c43d77939mr1393043785a.62.1790493298609; 
 Sun, 27 Sep 2026 00:14:58 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef5f876esm127947425e9.2.2026.09.27.00.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 00:14:57 -0700 (PDT)
Message-ID: <ad3b3719-73c3-4c0b-a77e-aae131450855@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:14:57 +0200
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
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfXzjMqmhbR79YK
 gPWJwxDqQ5MqNeB1nRvY70c9yAyMz4hUCEJ4gKgnggrb25fJHnJ/ud2HXAMrY2L+431UG3RJny3
 kn/A1ASzouFXi47HWZyupESjGm5IbutFE6idh2wx+hvmpZaBvSQpATsRMgE56fglMppOyCuUYBU
 UbOkUnDfSr2sp2j2KUukdida22Pwwln7/CvHcaQJm9eHZxlfiK5K2idcx1+aHCnNX8yvuuxMkw0
 O79uiw3QPuFEHFfA470pjvlE2KWPOPFmjFTcp/JL1jFF073d4n6nT9RdzsLlBrFyc8nFPe1VhXM
 H3uvUe3CYpfVL8LAymouaXFDV4HG97FdF645xTMTAlCm+UayQfZK3m4CKC74QMyeOjJZNSkueXg
 OeJS9OVWd6PSBD6tpx6kaue7sog5FEGa1N3QIbQZv3z4BNe8QflUOdI7BteBmleWPG56ogzSZFr
 lBhw10Rmesv96yNGCZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfXyBWQ6kFyvOOf
 WxQ9UF8SSaQM1cyWY49ytW6QS+0GXdnoOPmpMzg9DqX6NCiK9LmtgmnGUjnpbuWCXBSd+2hQhyO
 D3JLKfvJmns3nm+j6+ZsTyqpC6DGJzI=
X-Proofpoint-ORIG-GUID: ZbKMzLl16iGl3rind8Xb1SAdaJkYtvK_
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab8c274 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=qIEN1zWNEFoNWvbB_woA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ZbKMzLl16iGl3rind8Xb1SAdaJkYtvK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Series queued, thanks.

