Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F3ACDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwzd-0001eu-8L; Tue, 23 Jun 2026 05:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwzZ-0001eF-8y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:00:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwzX-0000UK-P5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:00:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6cW713338321
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QDg6FHtWJEG5IK5KCsh2BghZdp1S/hI+DbDViUZkQHY=; b=l4Rgk5n1Frj/bNvf
 irmBIC5U/yLIcGIH1jUhKRCnqaxnwvpH6gCTNauht37Pd/+fyvJEmiYlxtDeFnBl
 imvOaR6HYUPP7dn8jG2ijYQAtQCxjYL+J62t6kqZB8DjIwR9XhmdxTrQjYHKxR85
 KHFXeMjuUfaPAh0g+64IJrQsHGunluq1Dl0FcWLy7mn3qmbRUm9iRAfMxh96f2HH
 6xpRtu5JmL9sJ1IaQSXvXofQzWZTyjWfwIiLgwVY/3Czum+2FJJX0Wx3bvSJ86by
 ZBjXof859FHaerlNOl9D5x+xMsFLzCIkp4MYgkKRINwYD8vXnL3bW93JNxoAqf5n
 4pM2gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjhe9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:00:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157de5360fso160640085a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782205221; x=1782810021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDg6FHtWJEG5IK5KCsh2BghZdp1S/hI+DbDViUZkQHY=;
 b=ErNGcmWG1q3MMtAPO+b7YWxDkrILuwZSdjpRUX4Ff0yqObvxkD2D3dLg3RTl1dog/w
 f7Hoo5DKfl0zJyO/u69oOZA6ryNE4lHm7CY0Mh7klRKu1Ru1kvw4FROKEjKElR+Z6cYk
 kUQZTtqIRYzpF7VKH9Oe4aMqFDKC5OBPKTNh+D6QiC8Ee3xhG2d19efeMj89VfQCH6+Q
 O85NeQB4rNsce4zarAyW5yJApm5VEZAMzNll4mYdUruLVlGYcFrzBmvs8w5tjjTz6sa4
 +0rIdDAwB8oGpCl4934QzxLl8zH/Ot2rd926rnrnjvg3yQXeKcfApF7kNw+w7nsfRsa/
 dDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782205221; x=1782810021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDg6FHtWJEG5IK5KCsh2BghZdp1S/hI+DbDViUZkQHY=;
 b=AL14MvfEqQR71NGYdNJAODZ2mMneOharx7PTvUuV8ic7BHcsBa/XDcc98wjL5o13P4
 b7fbUdmCPBcPri1SftKQKdoVgy9ueGPROKudSLLBAMA20Z8XbuGYiqKPpURq6sAVCTsL
 uC+lddklVo5vKAQqfqh4SIQEuPh2u99isLdLjSFe4akwUfAMCoFoah3xTkD5NtmzrH/d
 L34h+NpIYmxh/6y3F7PxyDoBkuxrwqxXG26cUYYLoWGnngkvY7SBqngZYVrvoqf7oTBd
 h3QlsjXVsgRYL1VWKhPgrPk3Vg6kX9hXoCeFjO+AUKdPLXva0e99eI41SLD2zJMzlzza
 Tisg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U3nZl6AygLalE1AWXur6fqDwnSAwUBBp2zorOkS5XTn6zmxMBgk16ExvI+wVgKKIUFG7hOxQ8ro9v@nongnu.org
X-Gm-Message-State: AOJu0Yy75+FuQySVmgEpObkBMcDwOWDNJ4FiBNyBx263KhyFzICrzAp6
 v4OU+Iy7ui3zF4rph9BW6lswA2HhbyTq7Wslon5qRfi8oauZGLfH77cY5OxIkJPotQX9OdZBqDx
 bPsB7zJysf/jGJn88s7EpzPD/R59oFhEDRCKLc7vYNIXIAwWaiPJKi3JS+Q==
X-Gm-Gg: AfdE7ck6BSV070YMGtfTOoasimLy48rZ499Osd6OWm1n+mfYMIcTl75a4XQRkI75+ko
 PaW11C2MckOBSc4h3Jc6qf033xhLuPuyoqZ93QjlFxCg6pICeEC0jvcvNXW5p2yopblUHCOCs7B
 Az/3nDIoGB6pe1ASnniZlogUa/biFa7fyt9gaq4onQr/IolWJeZN7JXhXeaNcYCQBcT900WG82W
 BLhcMcKfNbJL/9pys/OijsKK1rxIkUrMcC9rgltmyEvXEqGF0H7CKSX2uP7WcMns3VAsSgEY1l/
 bEJ7N/BmZTSA17FpYx4mie5Fg3PFShNprugTy2RztvR+cnIVOeHFuugv3nS/2fSHr1QWmbbvIRz
 PlkHvdP7qowGmdQ1DdNyRoVou4vlGcpxDoy+Eec+36FrEPjF/P1Rhz6xI02avUg==
X-Received: by 2002:a05:620a:29c6:b0:911:c5c0:d5f2 with SMTP id
 af79cd13be357-925ffbe0f89mr451666485a.1.1782205220294; 
 Tue, 23 Jun 2026 02:00:20 -0700 (PDT)
X-Received: by 2002:a05:620a:29c6:b0:911:c5c0:d5f2 with SMTP id
 af79cd13be357-925ffbe0f89mr451657885a.1.1782205219778; 
 Tue, 23 Jun 2026 02:00:19 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c6161ec94sm475395866b.59.2026.06.23.02.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 02:00:19 -0700 (PDT)
Message-ID: <aa3f8aba-b256-4f56-a4e7-79b1b2f0f367@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 11:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] igb: Refactor TX path to return processed byte
 count
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
 <20260622-igb-trl-v7-4-abb960e767ac@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622-igb-trl-v7-4-abb960e767ac@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX5xh2+Zq8h5/U
 ABDI/JYHI6P27ibfcYgqpFpUQCgMG+7r6jYduKT0viDNk+pZruUr/hkLhjm58AS1xLdma5KvnSa
 9DDjBJkzqVEZkvfNwaI/TklpsDxnGN4c0kyNcUYl+ErA9sdsTjS0Or9WV94ehAzeYNQS2r/s4e4
 c9jU7811ngiaon8E1dw4z81zeperxgft3nEWIH1uQzIiNIWssEJZK9s6E2Wd/fYNzfwsgZHRZoZ
 cVzmStsF0+pBY5oTZBmQWcDgEi+xUxd7vK8riGDok2Fz5o2FUd0ybCqLk2O/FyS/47vXC1GWVOA
 91+3ohS0Uy91m2fw/uiOL88PNL0tRGhDHNrY4WU672CuzipVsaPlvrT4E38suTtZq7+F2+fDtnL
 +FOh1u5QMszAm9cvp5/RZF6YT6TP1VhPSM5daVhAK8MQOJuM4bXbiet7qNVjB45A/xLwjtw1Bk+
 9rksn8ZalEXiNNewOMQ==
X-Proofpoint-GUID: hPQl3VRTOTy5ETPCm1Stev_cmfj2rgMg
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a4b25 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=3jr_9Eaof67Eon-Z6BgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX5b3IHYr92BIR
 a0BChm3HcH+7+NgDrwDPDT3qPM0OH3e/jgWBhviO95+z8wiTlJC3TS04OdW8+NrYbHZN4h9yKT5
 ePJ5rF496Fe1VUxjUSyBC15upoSa7p8=
X-Proofpoint-ORIG-GUID: hPQl3VRTOTy5ETPCm1Stev_cmfj2rgMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230072
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

On 22/6/26 21:05, Josh Hilke wrote:
> Modify igb_process_tx_desc to return the total size of the transmitted
> packet (in bytes) when processing the End of Packet (EOP) descriptor,
> and 0 otherwise. This allows the transmission loop to track how many
> bytes are being sent for rate-limiting calculations.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

