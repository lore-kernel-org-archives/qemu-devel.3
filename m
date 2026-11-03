Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B8606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EJvJ93SJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZA/aW5oe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOF18-00019r-TZ; Tue, 03 Nov 2026 08:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOF13-00017u-MU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:57:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOF11-0000Qs-PM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:57:33 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZBG72971460
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 13:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J5uy1WATm64CFRZAJKLSh/dyV6DATwuE/e9EzLykkdA=; b=EJvJ93SJ5CV8xjmL
 fMBtvwp8lH0a4lWrScjcnw+MFW1HXwfA68lOJSdLUhwdhowjalR0e9eK+vamnnF1
 ZPV/AGNWOX6oVpeodphA1Mfi/fH3Po7/IJVjlmed2WtfGH+zVayIC3x4WU7bc2RP
 iFB4JuMwW+H3TGJ7h3hZu0JYHN+WlIuvoFuzS8yNQWo3ZpqlPLkOX9tU2zGtx6vr
 YDfHayX/esqvyANoSrYyw2K2+DSMPHi+bRwFWukd0biKrzzs1BA6dbN8v421c5zc
 CZeo+o2X4zAqJwo492Z6LR3ltJFRdivE3o0lzAukS/XBD0GUZkuKZMpF8MrC9iEp
 d4gr8Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jye4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 13:57:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bfa915da7cso566980137.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 05:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793714247; x=1794319047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5uy1WATm64CFRZAJKLSh/dyV6DATwuE/e9EzLykkdA=;
 b=ZA/aW5oeTlMIB+1a9/efqzyHEixhA/yXn1tz3DOb4dXfL+rmHLxwS4lpDnscCvBo4u
 3TgWcRG5YBF9QVTGdBl1gn6iWcn+Mxy9/lfzI+Np/Wlpal+/9Bhroe/TdrmjyE0/yQx0
 v1gR7xdoYDz8r1liSflqtkRs1jVgRx7sudp3BzUPcM2P+EzsW+t0L3F0IT1gJW2Odf8I
 RvGqKXSh2exnBSBX6lyKhaDEsFpGHC647WK9a94CXgiRLotQWBpkEjxx8j6mY4SDAInG
 QQr9XoILi75kYVvJUK/BAxNlSLjkY/kvxnAgUy+FklFumv3F+f/oW+EXEfw0WcTr4AJy
 eAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793714247; x=1794319047;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5uy1WATm64CFRZAJKLSh/dyV6DATwuE/e9EzLykkdA=;
 b=2UJWcMkF1guhIs/vn360cJFQaX1KjrZK31O9AGOGgDKdDz5cxmUR2L1SD2WR9ORxI6
 +itiJPBbTd9YmNpj+dECg4JEN2N7OaTApUzWVIxXvniBT1XidgJA4gdRZIeDpQMaEF1/
 c/WnU29kVVWhudhOhxN/Zrt3Y9h1918xQD1J4QYGQ5lxJTFmyJ6kpi4+A6Vh6NuQ9EJj
 6CyCYUVnCTsvQNEEwbRVrO/cgWjPO1QRmVBd/GEu4lIFZW32aWS+YRUVtn1hdvDCV002
 nP1eG7JzAoznVz2lUIxhvCbeQKssUKUsaHCe/BJBvGMWxZRUK1WuG5KK/m2u2GOxK2nL
 G6Nw==
X-Gm-Message-State: APuU4Z/lxrhqPVPJwEwcaJoWOHJsDS1GyUqZJmoppaQUAKHwTJ4NN23q
 0xJppxDQqn7CMEGpm0XXqVIkrDn7j1J+gjaxXxb8m/sDxQuWcww6W57uHMP6MRDu5Za3acHQ4am
 66HfCeFz6nB0U+cY4nH0ZxQvE6f97gpNf++vnA/OGOAibu0EgCyvDq9L+fg==
X-Gm-Gg: AYBFou1P/8eUJeoMlNszIU06l9iI4xaPx995vn4SUh34E1DUTM2r0YYwQOjjDhb6xoP
 rJwxL3k+mk5j6mF7R6G+EW7ewVxjdsKGNdO+6nO6ajnJXplN5YoXgPTUvsE24ijC8evo9YGBoV+
 21+qGAhtGUKlTbv8eXhNMzWEeBI+ShoE5z6Caa5UIb7Udjt8tA3Js2Lih3L66jmTXGVAYe7IYCn
 B2UvjSVgu79/itcwAZUWnDnL7vBlg++wG6q9uciao4QN9IoMUe76tsFmbCG+zee8UWveNj2/fru
 e5c6R9a+mf1OgZXN31RQZaGGcTwYCcVEL+EKXq+Zq1zTrTaD1xXeXMJX4rzI6V436475mMATE0c
 QTkWCC75tIazVZw01qxW88p9FhwFFUXrIHKmHayFzbnqVzz3getoXnIJJ9HqGHLkpBiE=
X-Received: by 2002:a05:6102:a1d0:20b0:7d0:c290:6aec with SMTP id
 ada2fe7eead31-7d0c2906b26mr801675137.11.1793714246799; 
 Tue, 03 Nov 2026 05:57:26 -0800 (PST)
X-Received: by 2002:a05:6102:a1d0:20b0:7d0:c290:6aec with SMTP id
 ada2fe7eead31-7d0c2906b26mr801667137.11.1793714246253; 
 Tue, 03 Nov 2026 05:57:26 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm25912049f8f.30.2026.11.03.05.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 05:57:25 -0800 (PST)
Message-ID: <c173e981-3589-4731-9220-d9d1b75878e9@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 14:57:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] net/eth.c: In eth_get_protocols(), don't report
 SCTP header off end of packet
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
 <20261102201828.1879576-4-peter.maydell@linaro.org>
 <865c4fd3-ea62-474c-97fb-7940068553eb@oss.qualcomm.com>
 <CAFEAcA9uA6isj0Q5aLtD=LcFrMaAYfP9cq4hdxwU2Eik-zuRzA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9uA6isj0Q5aLtD=LcFrMaAYfP9cq4hdxwU2Eik-zuRzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rxTgBzGjr1xlQJoS06gL9I9vqDjhMgJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX1mi69J7xjOLe
 TPInMubS/zYsj5zGAoejfYvNiDDbo5Ps3hLVxxYm52jaFcVzNWtJRi3O8FK7REG+btoSRCp/cSG
 n53rAtz7+j6zapo1AyJ12D1hYOM4gFcmnGJgudCjzI/aNXN0LWKWXmz1/IDVv7eOZqWVClai3m1
 FoCoAgFpwY1seXv2+87V2Wq06OgLZRr0D3cobhSWuMCT3b8n7geFDsbJSZQ98kSZDtHbMhyH6D7
 LKYxqVSDTnIPqzHQkInMijLxHj6HedBygKmSg9oiaMAOKC6Y6YoHz53Nddk0ueXnvdzobk72AnW
 2g9al0Lt2IhfQZYzSKzoe3Zu5tqNPslJLW6j3Mh8HfklyhjprGHUk+tYP+rTyPTlpZegreVGV5T
 MJRMC4l80A5l/CQR0oY27cEMzGSF4tl0a5E2DhwVTTT9p8WjDFMpINDgdZDGReW6to+PTZ5viw3
 kXOnZE4BuVZIUf9thKg==
X-Proofpoint-GUID: rxTgBzGjr1xlQJoS06gL9I9vqDjhMgJC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX/Wnpqq9lxP+V
 hi7RUY0TecvqEGBL1bcW7bLDIA2swuv7/09cHggBVWTO7fYhibtmknwLdwH9dOEQWV7Hgpbw+T/
 ReBNELNf62lOGl71GPRb0eCLDBFhPdo=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9e848 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=iDw3GeftGWU4ZHOe0o4/TA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=Ki0F26UDEml0v8tzJEQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030055
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

On 2026-11-03 14:24, Peter Maydell wrote:
> On Tue, 3 Nov 2026 at 11:51, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 2026-11-02 21:18, Peter Maydell wrote:
>>> eth_get_protocols() parses an ethernet packet and tells the caller
>>> about various offsets into it and other properties of the packet.
>>> For the L4 protocol, in both the IP_PROTO_TCP and IP_PROTO_UDP
>>> branches we implicitly check that the packet does contain a whole TCP
>>> or UDP header at the l4hdr_off offset, because _eth_copy_chunk() will
>>> fail if the input packet size isn't big enough for the whole header
>>> we are copying out of it.  But for IP_PROTO_SCTP we don't copy the
>>> SCTP common header.  In this case we should still do the length
>>> check, so we don't set l4hdr_info->proto to say there's an SCTP
>>> header present when there isn't.
>>>
>>> This shouldn't have any visible effects if the downstream consumers
>>> of the l4hdr_info are conservative about checking before they access
>>> into the packet, but checking here too adds defence in depth, hence
>>> the cc to stable.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 907209e311 ("igb: Implement Rx SCTP CSO")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    include/net/eth.h | 2 ++
>>>    net/eth.c         | 9 ++++++++-
>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/eth.h b/include/net/eth.h
>>> index 46dc9ed5acd..e10684ed923 100644
>>> --- a/include/net/eth.h
>>> +++ b/include/net/eth.h
>>> @@ -394,6 +394,8 @@ typedef struct eth_l4_hdr_info_st {
>>>        bool has_tcp_data;
>>>    } eth_l4_hdr_info;
>>>
>>> +#define SCTP_COMMON_HEADER_LEN 12
>>> +
>>>    void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>>>                           bool *hasip4, bool *hasip6,
>>>                           size_t *l3hdr_off,
>>> diff --git a/net/eth.c b/net/eth.c
>>> index bc26d38dc21..341d3bdf02b 100644
>>> --- a/net/eth.c
>>> +++ b/net/eth.c
>>> @@ -213,7 +213,14 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>>>            break;
>>>
>>>        case IP_PROTO_SCTP:
>>> -        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
>>> +        /*
>>> +         * We don't copy the SCTP common header into l4hdr_info, but
>>> +         * don't report SCTP as present if the packet isn't big enough
>>> +         * to actually have an SCTP header.
>>> +         */
>>> +        if (*l4hdr_off > input_size - SCTP_COMMON_HEADER_LEN) {
>>
>> Hmm don't we want the opposite "is SCTP common header complete" check?
>>
>>              if (input_size >= *l4hdr_off
>>                  && input_size - *l4hdr_off >= SCTP_COMMON_HEADER_LEN) {
> 
> Whoops, yes, I have the sense of the test the wrong way around,
> should be
>     (*l4hdr_off <= input_size - SCTP_COMMON_HEADER_LEN)
> 
> Doing it this way we know we aren't going to underflow on
> the subtraction (input_size must be bigger than 12 if we got here)
> so we don't need to explictly also check for
> input_size >= *l4hdr_off, but maybe that's being too
> clever and your way of writing it is better?

Ah indeed I didn't read the full function body, we already have
a complete IP header so we are sure input_size >= 12. Let's go with
your way otherwise static analyzers might complain later about
impossible check.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

