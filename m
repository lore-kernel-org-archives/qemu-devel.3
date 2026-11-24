Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A50606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pD03gFTd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NNTnx30v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvrP-0001vA-IJ; Tue, 24 Nov 2026 14:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvrO-0001uw-C6
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:22 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvrM-0003gd-Oj
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:22 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXQ8p2037000
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J7M/WTJUSRvl0a6D7AEKpml2LNbMVOWiq3gKAetsE+Q=; b=pD03gFTdquS0IdJn
 OJaI4+JkL8MehlSMZka02aR5JUb7lfEr6kcGa/YLei2D92lwfikeOoMA+b0zrRtY
 F86Y06WK7ZiAOiyDtRFmyzNJsPdLBIrddpRoJ9YpbfFH5Y8Poz5RxkbDMzzGwDhI
 cYjo5CZYWhRNNA3epj8f/ZtEQ+NQGfNcXCmqlUyzdrlKyqrO24iSeRQrWukUg/oi
 KtXe3WfWFtLB/67wqZvBvzsoT4IL6oNQEGBMOOvpN3BSVJbPObEXqZZYYqp1UKO8
 WkHhD83a76vWPACtUxgCAU2qptHz7t3oPRPdyruqK+M/KqkX4hUvlGcabrX2B8wj
 YtGjPA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnggw6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5408454eec.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547239; x=1796152039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J7M/WTJUSRvl0a6D7AEKpml2LNbMVOWiq3gKAetsE+Q=;
 b=NNTnx30v/kOJbpgRmTzj9rmlgUXqRuQFKIm/h0jQjmLEASchp3ir8dVv13VsCFIQZ2
 Ub+CU8Hr4N6Y2+/0mR93zIJKn0FnO2Dafxf6hQQpWfunWBwgayYwgAfYctH/69+hNs0b
 UhOFzuW3oZtuZkm1XkaIaQ4Kn2Wik4MeF+C6gjKaheILCMU/cHBF0rSa0NUlJ9XMoiTz
 i1YpcV88TZiOyRrYRVxUTNXXl8IECc62vEHv80ExgVe7JLLwqDuLXtOzsfQLwLyQ6MXv
 QhXcWlXAJXsVkH6B6PikziifpxsQMVLYyguHkr2uHqjruCKFe2U1ywOtvIjRHuAwPbEb
 5GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547239; x=1796152039;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J7M/WTJUSRvl0a6D7AEKpml2LNbMVOWiq3gKAetsE+Q=;
 b=Td6FJ2XUWy9vRE1woqilPXsop/PTYpy/2POdZQ4JyoD84UWPaWuZrKoH+ZskIvnZz7
 0LJ4l+dYZKprcxANdLyHEtudIJxbA8/R+zIPvf+7U5i7LMkh1yWGsU/5YbxwzsaQBRCZ
 O8pWfA7vWY3ryPt5HK+Y6VZ8tysufrBf0Fub3VwT46tEYy0xzZVSiac4GGOTPGzczCQj
 NXPrXyiOdkLFPp2zcCJjBGQHjbqEwZx9WGtQ9DoyRmfn1SNOq9uICGvj9Wom1S2aWLP8
 8Jh47rKXzOuzt9SDheO/8c8Xx6Y1aVOhND+zwLphSooz0qh5iPNradg8CnYrw1mdWwaY
 wJTg==
X-Forwarded-Encrypted: i=1;
 AL+hErHzlxfnECZB+rHaup4G0vWKhlB8895Z7TQw6EWDW4M/OF7b9gM69MAJQVmqXt7XvoMLsT9Py1DQsydl@nongnu.org
X-Gm-Message-State: APuU4Z+TlrEpLaJo3g934sKNPSml15FGy11+6zdGsXx3FdhtuIAfnAnp
 DoW7RUKSJWOKgDcigYzcledQUIwZXxJqOUddb6e4APVNgxns1wG0zMZ2VyZAGliDvjNteGjP2sz
 jf+Z9sPq5YxvOMadF590bSH8T+lLnl+ggZw2HL5Rv0gJrhnzfzWqIvdRgLA==
X-Gm-Gg: AZFdTZdh3OX4pKkyPQLMQQGjMTg1bckpdWZZIthZYbT+qpxo1bO0E7ECuvonTVpRgpt
 k34KKIhvdJmUpokFzAeRC6j4kOfdWt74ejJxSGG0PPg9i2zr1RuFsx6E5Ts0+E9fdnPRAVPNqZr
 QZDDO+feOMxRhXhRskVvYl8Edpe1c7rqmwpSx31htQLXSuH1zRYy3WyiSfcTHV0DvD7FYxyra8y
 cZjLUSeukuQm0bP82ZOWG5bQYLH/2PnwXBPALz0Q5un2P5wls/xiGj2HrSe0kznqAuqi5Iz2Ckw
 L49sLvfTR/PBAeKhQzz+XpQOjx9wUo+h5d2qp8MQ3LqepFYUTG6UO0p5WpN0aVGGTdukgpRZ/W4
 mxZupqXHZ1qNiXSldLqbv6UmiWavgUW9VoyRzRfZ2/sAA/SRx+kAeqQy6oEo0+ER8pIQ5BD7yM0
 PJXe5wx7CAXC6muNPQ4VSI2CSiDhWl0LyRAUJpomXsxig=
X-Received: by 2002:a05:7301:182d:b0:386:b801:cd06 with SMTP id
 5a478bee46e88-386b801cd3bmr5117798eec.40.1795547238527; 
 Tue, 24 Nov 2026 11:07:18 -0800 (PST)
X-Received: by 2002:a05:7301:182d:b0:386:b801:cd06 with SMTP id
 5a478bee46e88-386b801cd3bmr5117782eec.40.1795547238044; 
 Tue, 24 Nov 2026 11:07:18 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567ea2cc5sm43845663eec.29.2026.11.24.11.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:07:17 -0800 (PST)
Message-ID: <bf686787-e545-4fbd-b442-1f985517d9f4@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:07:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v3 6/7] target/hexagon: raise decode failures at
 the faulting packet
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
 <20261124190314.3882017-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124190314.3882017-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX5az7a7CpU5N2
 tiBHMeepARdV24PC5Fe0/iolYR/MIJTcW4U9N/7rshjCqUAVqJas5P7MPBLp9OdW7oILr0wHhJe
 X5/2HyyU1dqbCxDT5x+LFDb4ABC9GpQ=
X-Proofpoint-ORIG-GUID: wlelefMySjsHkS8qMpz2Gu3Q2kEU1WD6
X-Proofpoint-GUID: wlelefMySjsHkS8qMpz2Gu3Q2kEU1WD6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX8LM/k3J0w9fN
 jwVn0RNzD7db4V/mrBg4X3z5xgTKRAQ7KQmUxUK7x9iUpKg2lgEVKultR67ylzQyJvxvrWniEkw
 y59QTCWnFJASbM2tpOaNlC3bqeAN8SMjPt4BB5QKJPRl3uvGr15JW21EUdTI0Sit3Hpq6wvdG4R
 d7+MwJUxttmHrhQJO4SEuAa1xpzUOX+LfGQh3ohkQ5HRgX5FUYwwYCEMIDXb2kFdgkVBtB08lEU
 1kUPPut4stV4dh21XAR+YB3BENywnZXfycIsFVUk17FtF0wXtPu8V32gPuHAAHKAc9fjCdv6xyw
 p3qyu/RBAOXHM7q/fcmJn5cFQgJIHGS/vme+506sfMVRFANvUDRAPKCRA0237JVSIrFl3BIPO7k
 MgTvWM+OzHUtH1XivP6LZ/gdIcVEB1bPRuNbty0z33ADGRhP2wlowwT9WAHwEX4Xup20I7Dft7l
 RD3bdQTRGbo+XgcPWYg==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05e067 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=UNNuRtUbfasyN9gQjCoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240075
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

On 11/24/2026 11:03 AM, Brian Cain wrote:
> A guest handler for an invalid packet or opcode skips the packet by
> advancing ELR past it.  gen_exception_decode_fail() raised the exception
> at the address after the packet words, so the handler stepped over the
> packet that followed as well.  In system mode report the address of the
> faulting packet.  linux-user keeps reporting the address after the words,
> which is where the invalid encoding tests resume.
> 
> This enables the llsc_on_excp systest.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c                | 13 +++++++++++--
>  tests/functional/hexagon/test_systests.py |  5 +++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

