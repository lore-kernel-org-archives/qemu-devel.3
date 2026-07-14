Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FEBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZGt-0004R9-BR; Tue, 14 Jul 2026 05:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZGr-0004R0-G1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZGp-0006l1-Lg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E7YPJh4102092
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kjhdXuHcpMn/v6GijGZ1NMpVz3NkCF7HgJhktpSjXpE=; b=o25sUA4iA4w3S2Xf
 BIczSf5Llx+Cj8qh26M3fnEEcZtX1wo4dgWSvNXMz3TQJPNmgHJiTkahtdlJT66O
 7dL09wIrIAZQ7iPYNS4fkPSHdDGH/0bQfeLF7rUh52LJoNQNUKBjxE9IBosr7+Wh
 8QKruhWGUCY4n3zDWITTDNParAOnaDs5UcYLBpmU+K1rBJzIbXmTbcg+HqMRImvE
 WPPBWrl9EQKwm9rwj7vxUlMkyHc/nsYSUKQn8N+Ge3E218HZ9hJxAEzEcVn0GHfG
 YUwM6U4CgPk9OsoqTeglWhWTRWMuX+zVK6JzL+mp/s2qRsc3mEc9dXAEoj/CpKFo
 OTkA+g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudgcr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso82608256d6.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784020660; x=1784625460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kjhdXuHcpMn/v6GijGZ1NMpVz3NkCF7HgJhktpSjXpE=;
 b=SzbNHa+3nrAq1Shzd4UPh8oMQ/qAG6iLVUfO94ioGwRUPE0lLdMy+0oGr3Ec3hDQZP
 2jEITKf8LyAVP1JkqnSvqaa0z1Qay6l6mTWm/Cc3SXTQ+YWIuueSyTjIMMRvJ/HhBLgZ
 Mh7HYpL+G+cBcYQEzWm/IB5+1p43+kOfsOsdCgHB1hVVusY1x92LQOVXONRDeSh3f+ph
 p0w3OGIkHWMnJL1QW4Ath4sxwdSuxDj6Iq6OdIya/8FfSYeEzdBDz/LwSxAQA8yh6gt+
 WeL412d/OpzX0PVHZA2MGJlgc22gPA47/q7iUmiD20fQi4v/pjqDmFnao7nSdF9aYglZ
 5xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784020660; x=1784625460;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjhdXuHcpMn/v6GijGZ1NMpVz3NkCF7HgJhktpSjXpE=;
 b=N0JfAL9BZbna9GP5kgIeNqaf9YLRkI2RkFWGEE4+1K+lOjX30Fb0NGe15HjhIbs6Mv
 L2lBYfPaidZxBZTMoTzWfzJYq0Z2EwqWWe3bnlbfmHibjS7MPcNV0hlAlIv67Et7qFmT
 zdUDJ5ZJUNuUF0aWnl9NjQCT6r1XAvNpbgfPYTU6ZDXSBSxgCuQ1fIqb0Y32KcbZblFf
 NKScW8b3EgQuo25PFBXxvKRAUag0PJyDlkZ0VgSWuGq/FI18RiPspg3rjviBK7/w2ncF
 G4yZtT7m2oKfqIcboXCLLZb5WjJsJ0lbZSjMj5xkqj0cTNz7Jz63ZckzJ+dKv6cSBwRc
 VqAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUn9OKn/7YxiG1i55lIROmTCKDj8BWzEvD6S3WPaXRv06fC7a0VpebHxPAuIQMZ5hU35/Ycflc0mPG@nongnu.org
X-Gm-Message-State: AOJu0YyYTGfAX3zEn3uftsg+pc+4jEmAI72do0sYT9ge7k/KK3/PHXzu
 OxsF5LcxbKfoFS4hbsw+nwy9jl/w6URBIiQlumWDcNUl3CAm/txDaD5+tzSCJdf7FwbSGnLaMDa
 b2EWgh4X50hBnHY4bTFV+P1Rm6BHVsIqy5pesByA4bO7OEELajKqjTOE1iQ==
X-Gm-Gg: AfdE7cm3J8xJYqqs1jmFU2CwwVOkZZUXdn1ZcjiuTUw129SjRO10si+2bzpT+TuFhY2
 pspN8AUlDwKNVe17S6M/Uqs8qtznsxpI2ExghcfDHLSfeDI5hoqIr+xd79xR1WDuQbOPEbEuVT9
 av9ccyx8Gwe7cg/EagiU4nfn8PBuWzNA7SiaG9zG8NtM9t+0H/4j0aX2VxSDHgT8kgpbuPp5Xmx
 a7DFNwSVasjdd5gnukllP+uAf8CRthSNO8Bfk52CwAAYo6q/IPAHwTTBY3DF4LBlcAH/feKyWxs
 hsFamjCj/oN0GGZgQpdNUWLa+lMGk9aOt06VaQOhW3DasOlJHEyPuX8IsGxP+D75pXrH2kodmaU
 mit7uhO05stAvSbzS9MSNzrZE7rJUf0iTlkiDP0ccVB8U+Iq9qclN1X4ijSC42A==
X-Received: by 2002:ac8:5d86:0:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-51cbf0ed069mr120758271cf.28.1784020659647; 
 Tue, 14 Jul 2026 02:17:39 -0700 (PDT)
X-Received: by 2002:ac8:5d86:0:b0:519:efea:cf41 with SMTP id
 d75a77b69052e-51cbf0ed069mr120758101cf.28.1784020659289; 
 Tue, 14 Jul 2026 02:17:39 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15deea5cf6sm800420966b.16.2026.07.14.02.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:17:38 -0700 (PDT)
Message-ID: <533b278f-d5e0-43c5-a1df-18ff05aa7bc7@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: only advertise passt in netdev help when CONFIG_PASST
Content-Language: en-US
To: Rohitashv Kumar <rohit.kuma1313@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Rohitashv Kumar <roohiit@amazon.de>
References: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gQCtYYGywAlSb-GXKFAvpncv-7JzcSbA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX5XdeLO6tXVVm
 WUlLNZJfSuqD3qQuBv/p2zrY8iEthz+4LFc/yca1s2lyxourxZQghXFroVAOnR9RR9vQDPuCp8B
 t3h4Uw+PPUHyJBuMbzhq1IVVY5+l/scx9rZ7uWbNb5JQliG//zy/af+FPu0zlyVSWKez0601rf3
 NX0VhqkNWAcvm0I0th6PLKBS9BgKbqGmd03ADPGgVAHYcEhz5lJH+GNJeaKHlJROGpicDwlgvOh
 cwxEKqxwlZ3RaRJ0PhW6J7pvA3+iUP7Dr08UUawe4fR3d4EKoiD9//TNjuTf+nIItRwh4dd6bsw
 JXYfjXWOUSui1qs4D1wpP3TYDZL0Xb7ULt+MPiBeK9iIQaZoi/VpM9p0vArxiXE/5QrUkhgKf/E
 1EaREYRFUHTHUfJ4lwAXI/6HHLe2Mwf60R54ArQyCyDRKD7b5o2joGMXobqrMwvFo6nTev4YW7m
 T0js8+fH8tTR90I6MqA==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a55feb4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NiBTYWx0ZWRfX/qSqiKr4OJpf
 uZ/YvpP9v6Kqmz2GXymOoRIoTTByUudFLFSRC6Qx7ep/+C/DvR3eBMF82w6mru8jkj/1i9PbsUd
 AIWWSRFzWXu3eBtMf3eGpcsVhOTzbHo=
X-Proofpoint-ORIG-GUID: gQCtYYGywAlSb-GXKFAvpncv-7JzcSbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140096
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

On 13/7/26 21:45, Rohitashv Kumar wrote:
> From: Rohitashv Kumar <roohiit@amazon.de>
> 
> show_netdevs() lists each conditionally-compiled netdev backend behind
> its CONFIG_* guard (CONFIG_SLIRP for "user", CONFIG_L2TPV3 for
> "l2tpv3", CONFIG_NET_BRIDGE for "bridge", ...). The "passt" entry was
> added unconditionally, so "-netdev help" advertises passt even in
> builds configured with --disable-passt. Trying to use it then fails
> with "Parameter 'type' does not accept value 'passt'", since the QAPI
> NetClientDriver enum member "passt" is gated by 'if': 'CONFIG_PASST'.
> 
> Guard the help entry with CONFIG_PASST so the advertised backends match
> those actually compiled into the binary.
> 
> Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
> ---
>   net/net.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

