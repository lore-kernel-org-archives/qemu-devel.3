Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D59FCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENKJ-00023E-B7; Wed, 07 Oct 2026 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEK68-0003m7-LP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:22:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEK66-0006b7-En
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:21:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974lMrO3929609
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 05:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4s3HR9Tp5uPg38Kxnn2WwDMXV3ICPAPhY32b4hukIo8=; b=H/6//riXahtziFx5
 MG+w49ENePeHQx2N+pky/O4boGR+nVXTOFf9A/rDAeOD5E7Ywv2MKKJmMCGSNjdl
 GoaRwsx3Ii8JTfPYjj0W4SDLfMZOJGFc0UKJb5SDPMQHuGtAU2FnVfdDmNdHcRTE
 uSBWvP6g0LxzTSOb31Dt9JQ3UYmO/c4wy4PGEsQe+kRcE+/1TVrn5YMNFBznappv
 3FOqqQmYp1VtoBTM5y9p9JWORbB95psbt7WZIyaCudo1OvrjyM7ePCjCDchN1zaG
 7mj00JKPv1FiiM+8oYliF6Wzqgf0ley/mquOXmFUTZAoss/YP3INERRzgR04zEFh
 65shpg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5830q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:21:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934956beec8so784619185a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791350503; x=1791955303; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s3HR9Tp5uPg38Kxnn2WwDMXV3ICPAPhY32b4hukIo8=;
 b=L2o0qlRYKfJ/LKjhq5kRamtARjqH/aKdFECLY3czRtTxCCGN8n5VVdCsUYTsoIqpeA
 hhARi2xPOiqf8aeXYZSEwsPeHsufUwIBgb9rXyFNq0vNtBcbDo7E40y6uelRqMrU7LM+
 QUWyhJ54ZHUHp7fi/XQHIdxpgffpksDOevcwguOmBHhxslF2E2nrmuja3SY6fIw5Qn1v
 Okqx6NNAUQSwDet+JmNhhJgt1qqu7MUR/ziWCrJrD0YtA9/StfU65AL1XOrZ4IPBa8zi
 /8j1aiBS8MSgeXvgJ1KwVzd7N05+AqpQWhc1y3Xm1OhhP6B3y3DMdfnbtdLSzCtXQwCV
 KMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791350503; x=1791955303;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s3HR9Tp5uPg38Kxnn2WwDMXV3ICPAPhY32b4hukIo8=;
 b=aN4DgSlWzsUTNAmUxLeLGURaSz6uB/6pQ4KbqO5qd6pjcuesOs1atDB3YfKRtVoVV+
 FTYs9w9IDJztHICB8wSkXCslJRP6z9gvEUfzJB5eGOWN3BRd0LUhM1O0+CZD/43pXsQT
 ce6zPD9yE2h6ycTmP2D098cRmkO2sDAeJejvCq5U8icXg1hEkotRlvWOfDjAOKpUq9g0
 qbgVSKXSusLNGcFr3zDNKKOyNQlV+/0Q+4M+xa5N4IGfIwjmpRdZRJytlGWTETqaOCe9
 leClo5ugwwxnFtH8td9iRq2ohiGpV8B/hMvEXLE+cHoDy+HoJIEXamPxUFlQPXtOGAwe
 YF0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBycrC6YvpqQ1GwdYKVYAlJ3iyX4skMCC1mz3rFWb62tD8wMsckO11aQtAFaWWfW50vm8Pt5J03KTcWb@nongnu.org
X-Gm-Message-State: AFuF++l1OITiH1O6X99GCKjJFYJN+sCRKCMVYi+fEIQ/C92b+q46BquK
 ZdpoyfNkLKfWWjnM2KiUNP2Ebn1TPkv2LJEGGBifN2W627ckZZa/L8+WpLKZcijPYc7N6uJblIF
 2fMOaKtFFeTD8LrKafPx1Z1bjsmXqEL8Oe5FhoqBFdKk3xv62hBGemvH7gA==
X-Gm-Gg: AYBFou3nsgNbmSrQbCzn/7rv2oyDq0rkKGNOI0NnQM3ZmIsSLKU/sZ3T4AxDG2RoWJ4
 tgpvt8dHHI4xup3rbLZN89INZRPYQIi8Dp/oXp7buGFje22GMxB6otb28xyY/0EKAKQ50WoWCSm
 SjqmZ4f3tv7DV0DWWfJ9VpnMCLF4e8oH+pdLb+3C/Wd3pWDjehl1r30SRcsCU+fuBaKZrQcOq9w
 bsGs7XjriouYTbC04ba6onnPnbdY51FFsMteoywYVF3nRvyA+1vYd4lY20DHPatMpIiaCxmM95H
 oT/UqEAxMZvMg/tkthenhJ2K4ZiuMR9raG2pUVEaBIrpmSpjGdYGFmomyOwtRCLG9vCYkgl37oF
 yHhE9kG1pZC+AXdfxwpTcQ/y0jScbxA9KzA==
X-Received: by 2002:a05:620a:2915:b0:936:e18d:763d with SMTP id
 af79cd13be357-93e9b0f2644mr249653285a.8.1791350502861; 
 Tue, 06 Oct 2026 22:21:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:936:e18d:763d with SMTP id
 af79cd13be357-93e9b0f2644mr249651085a.8.1791350502428; 
 Tue, 06 Oct 2026 22:21:42 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a180303863sm18062345e9.3.2026.10.06.22.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 22:21:41 -0700 (PDT)
Message-ID: <c888a721-7674-4b24-9083-8b15c17734d6@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target-info: use TARGET_ARCH_VARIANT
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006182558.151956-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMSBTYWx0ZWRfX6cgzXJ56hAER
 iH/rX+AeUmIxXVW0lb/QHcbs4tmCFMMmV8H+eRgb2IOQ7civYfpB/ZquW/JGDEjNucaiqLF/9nq
 yM12MTKJWv9CyxRFWtzX/9eEuj7CXq8=
X-Proofpoint-GUID: UZRdPAPepqpU8x2C-j69HZhnhu1lZEex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMSBTYWx0ZWRfX2UbTAstHjmNA
 974qZ9yAN6oFPmHri70NbrDKhhxVYk1d+yN7BnXkpXj/pweI7w7+iGojUbhCu+6UtWa3OWX+J4D
 Ro0fdxdlRMn9DVavidcJPUAhDxk8wkaJMvc2YIhIomjUN9MlI3G/+LexbYYo6HgMvE4Z/PLgdrm
 WJEpnFJdWSV4D6IuwWPu3IW3xORu8B7uZQGk0KIxSBpZpzfMdEiy4EAoy5B3OsfkAxa2kIgegqz
 eHOvdROBLl2MW9637xQyw1ImNWXtylUF9FqHc/8pztgjGnvqmdP+HQ2SAyARISmnjgJtUMbF1MK
 5FN+rTz25uRKUlzLb5wjODZCst+r2C2/04JFrApqjoa9A54KoGReaDD+0dzpEB/jzjnjYrD2m/n
 NmgWbaKai/3X6HriUbCQONQ+I7m3rOzBlz9yyQDmqSzBb1mCNR0War5Jn64RCH4D95sAp+qp5qI
 Sqbzm71sO1UiSwjmEdQ==
X-Proofpoint-ORIG-GUID: UZRdPAPepqpU8x2C-j69HZhnhu1lZEex
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac5d6e7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070021
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

On 6/10/26 20:25, Pierrick Bouvier wrote:
> target_arch() will now return the full variant, per SYS_EMU_TARGET enum.
> 
> Fixes: e934c624f3 ("target-info: Statically initialize target_arch")
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target-info-stub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

