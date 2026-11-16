Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D2606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B/eEbg0d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WA66SEaS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzpt-0005gv-4Y; Mon, 16 Nov 2026 11:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSzpr-0005gh-4y
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:45:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSzpp-0003EM-EA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:45:38 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIRGu451747
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OHXjmG3JLRy2Z26NcrX/7qcd+LUQ6AuCVFaEFERdgPg=; b=B/eEbg0d5LlbF9bv
 ol7GUWBmIWTD0MQEItuL3tYeJOULHrnKKLR6Wut7cLm3ntZF8O+Lzs7EtPHatcV/
 xSVsc5CaYpL+D2yQjJxr4f7zvLM8zoTnK3qOwM8FU9fkJMWc9wbq1W77HAhDZQS0
 tLJ1KaYj4OuEUyB+z66UWuxE8FvruXKpFY1YBl2i876SVhF8T94zr0QGy0i//LRg
 BQCJWzRFqfXy84OmyGqR72p3XRCZNA/PH+pVfuE/LnyKbA2PqEKijX2tnByRiOmX
 D36JWRU9fWH7qvp2qEymMALcvP3Ry0UGNTctBZQO00gXpn/g/KAng9q7b0DMQLYn
 of6tnQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y0qhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:45:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139b62317d0so4802052c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794847533; x=1795452333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHXjmG3JLRy2Z26NcrX/7qcd+LUQ6AuCVFaEFERdgPg=;
 b=WA66SEaSZlNJA1kEUWdDKDdDNzRdsfKA07lahI+rmFwIi+ZLnNGiAS1wIOTiFk4OWw
 IaMqgbEtIgmuoVzBvzLihfoni4X6F0bSalB7SIdGvgNAKhUXNWj1EaOfmurvPxfPKqG+
 cvYEe91qu/b7Ub5agfVqIroOz/SE2uiZNtZCMUQm/0AO7YO9+SkGDmYj4d5V3uYS17lq
 XxnoAxtjWf7o46AOY0sAU5AcGXdhK3lkLHsq6jUG6uWDAE2yL79eRLq3NrwfujCbSmQT
 OZ8vivLRnDiQIxjQ8bkA6O65hznnh97FG/uy4e4GeP9390Uz0fWt/fENZPfA0CvjQp0H
 Gifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794847533; x=1795452333;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHXjmG3JLRy2Z26NcrX/7qcd+LUQ6AuCVFaEFERdgPg=;
 b=gVyO5GTzOm4G0600KIWbx0uRsZzJDv8k94ZEmAwaofB4y8xnAdQ2KEr07DuhsWyVJr
 71P8LN64I4td+eCxNHAe7YXyIdPSTxvWZ/pnPGJBsr9SWfLj9AZxXQ8Hs/eRzhiR7Moo
 TkR7AD8d1fRVqedsDGI7oM3XBp3C7TTRkuPWzZXBJFE5b9UkMHrz+KiNejA+R0Uz8PeV
 izMc91sberI/ApKdm8WekU4iyahCkFfC6jvo73Wma64EBHxUagxuD9wdI5GAlXhgMu5b
 22Tc3aWCe0GfjWHYY19PgjuICYLk4N/HdOdSNXcese29QCv+t+WpB8IxVnIUuKHhVLBO
 p1VA==
X-Forwarded-Encrypted: i=1;
 AL+hErE6P+Sg6w2ZasxrznVlg+8A1ZVT6yAwMC8htp6xa1mWk+usM1Xo8r++oMY60fr0helgwnDD+v85xwgc@nongnu.org
X-Gm-Message-State: APuU4Z/fpOX4K5lDP9wbyyeJLMr12EjyL1rUzdmG8hBNN/jTJauzPShA
 U5bPWRE+hpxQbFSr2TkuT7rFrtwKTYq6g/IZe1bedrsLMlAedcNvm7hGxpJtmqw67bI6/NbBbFk
 yx1Ig09J0JS3ya4dc6qRis1F81HixDS3pGdv+KpIzH9qz2jbsCy1Z6rzBnA==
X-Gm-Gg: AYBFou1Hbka2m5mAnzzcNwnQipGeZ2m3sPI8213K8kaJLLggx/X5CixMgyURmcQjjWZ
 EucpSWKQSme6tNpyoReimvfyUljUxONnpT5+nJ6R2OIyKHpO8C83lT26hn0FBs2Ce7Cg59ABmkf
 kqorfR1AWjm8IiIW82VCmTgZS5joVQuzpM+4MCaBPiAB3aoVYaCZOxtSu4etWd8BCKGRmv4dYJb
 G1mxpk7tMfmJcPPG8QfdCdSs87myVyqnnC2QfY3mogop0exrjtAYSxbyYFxXBFWblSVudNTmxhl
 gIFAfw2QPAabr9Qn55UYeQdVpGpJikWGnETfQ4JLWW2R8Jc2hvZt3vLlMgCZMrbX+FN9S8ax0z3
 bqXFRvMfUETaDOlA+5Ut3uL6TBYTRW6oAX5T9IoZE2YXrRz4FBbwkF9f3s5wnc3Bqb82uDXoViH
 BchzxEPgdtRiit3VRZtgSJJT0L9/zk09Ro1gtECpVFsYU=
X-Received: by 2002:a05:7022:ea56:10b0:1b3:aceb:b8dd with SMTP id
 a92af1059eb24-1b50317aa00mr11672284c88.38.1794847532493; 
 Mon, 16 Nov 2026 08:45:32 -0800 (PST)
X-Received: by 2002:a05:7022:ea56:10b0:1b3:aceb:b8dd with SMTP id
 a92af1059eb24-1b50317aa00mr11672241c88.38.1794847531695; 
 Mon, 16 Nov 2026 08:45:31 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b524049e0asm14206205c88.4.2026.11.16.08.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 08:45:30 -0800 (PST)
Message-ID: <6784d934-1efa-4108-8582-e9c237fccbb3@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 08:45:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pvg: disable by default
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261116144951.71940-1-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261116144951.71940-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z1aUNGUEEiI9ae3VxTsjWaB8bHIAYZsw
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb332d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XRlu76owGJAldEVi2MAA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: z1aUNGUEEiI9ae3VxTsjWaB8bHIAYZsw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NiBTYWx0ZWRfX9lafr2dJbN34
 SLSuyVRIVzyvOjGpStDvWfc+JcCVz2p0+7TDp5f4VvxsWPPHWJpvzZkr8ZH9GAD7Tun93reXxkU
 37iQDt/HXCnrx1lPcVVHpP1QQSS08Tc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NiBTYWx0ZWRfX7OgXA/zir0j9
 WhK+GKFT4xn4uOPMR5soDzvpZ+0xr0Iv9+GAKn9K+CRWJJuuXvNrlYHKVn2EuGuEln90PGspTv0
 B6GBl3kPLDe1lqBWj4/3fnQQWc5WaD7xseC8HenPHVFWj9dYiR6+q+tyQjdD8V3UwbtYYTrnGPT
 2ltRBB4aue6aceeyS4VI60s/MMRLCFhR+q/ZcKp6kG4r0d4o+1QS0D3pqBdb0lUG0penwnx/D2e
 xi1+NY0Cd6D8ijJkKHeFoi87LSY3i9k/A9MhzXDBXltiHyzKB2wV7RfhNz7fiqZ5bczSh9hmMgv
 cRMMsN02bTeSSiWJWf9BXaUwEFTAHGgYH/VTJCZe3NOUrTb6Rzmq9afAgygmTJOS4WbEoahdVBZ
 jwX/VwD1ZwhRiIvc6T+EMFTZ5FWdfNIDLLmMdeJiUlc+HNd4IvKbOhZPfYrZBf/WVw2rbNxEcc/
 UGANuEWnTetj8HFpkGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160066
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/2026 6:49 AM, Mohamed Mediouni wrote:
> macOS 27 removes support for x86 processors. As such, support
> for ParavirtualizedGraphics as a public API has been removed.
> 
> Current QEMU does not compile with ParavirtualizedGraphics enabled
> and the arm64 side of PVG is not documented or supported by Apple
> for third-party use.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  meson_options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson_options.txt b/meson_options.txt
> index 0d4907a0d3..eb049479f0 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -208,7 +208,7 @@ option('lzfse', type : 'feature', value : 'auto',
>         description: 'lzfse support for DMG images')
>  option('lzo', type : 'feature', value : 'auto',
>         description: 'lzo compression support')
> -option('pvg', type: 'feature', value: 'auto',
> +option('pvg', type: 'feature', value: 'disabled',
>         description: 'macOS paravirtualized graphics support')
>  option('rbd', type : 'feature', value : 'auto',
>         description: 'Ceph block device driver')

Sounds like the only thing we can do for now.
Maybe it could be a proper check in meson.build based on macos version?
Not sure how useful is it to enable this by default.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

