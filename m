Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67621CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZIAJ-0002mu-BI; Mon, 15 Jun 2026 21:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZIAB-0002mD-Kp
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:00:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZIA9-0002IT-VB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:00:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OSJc2094036
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oRfbxoOFvfTAzPFyrc9wxW2+PCZx/i84izz3Dv0qXxM=; b=DSj4UwyASxxWGUxU
 xDBg4Trfkussg3RImbwqElmv4xbdirMX0/Q9bAfw4p/F0uZLwVuFH9Bz8wzIcvNg
 wpnaSPtQeH6Pqj4VTVTKlibxRkXKdRGEW0L+jnq3j9013Q+PQqlaH74pqMzEm58j
 NdVQ+zO60pixUEgi3Joo9dILaZUwsmYgUdtDKZZ2B1u0WHRcyKxKXltGjZ/3Xges
 v/Y7bU0siyqGmJ6BsqAV1EJmZxgEDWOcXDunWo9bCr14UItGCZZgA7zm/S742X1k
 YiVd3+hIPqwtjvMDIN1Ux4apQhDTi90JuApwsTE4VYGUJjHYGG2hgCHuB93JZXMi
 X6HIaQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter23xq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:00:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915ba226a9bso998344785a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781571618; x=1782176418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oRfbxoOFvfTAzPFyrc9wxW2+PCZx/i84izz3Dv0qXxM=;
 b=FxPccY48NJbuOxfCRjiSmDT5Pxei2Taj4NFxb2zhshmrIHX3teNlbI/T1MZbg7Xc3q
 xl1le4mw7aa6DwlsGIrNHcJyRS4faW8tj92HKOdeFedd3ZILQS2z/X3JR43se4s1/Too
 5sjTcKVyiIS0CMquA8BBSo4bKayf/cAgRWpURL+C+zVQPkY/12dBn5LkAVrafggAEBB6
 DuKdv5cZ/vS/V5crJAOlEQrc21awBR1Z4jWissIcgJXG8bsBz0XzjBc9Ab6S4D7WNTy/
 DIyMnBXP65+NCRZU2ZneXE1wPGMZQsxoNC5ZIFid66pB13pXTJqQhtyNrr9/6oe0cqwN
 r7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571618; x=1782176418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oRfbxoOFvfTAzPFyrc9wxW2+PCZx/i84izz3Dv0qXxM=;
 b=CEc3rNtt7mZdRWcoKNtzwDREQ3B3zjIDQ4EWNnXFlyTw4HJpIjAODiXU1H6NthSt0H
 GzLofNlS95VRLebPyJpLCPDQDOBcQf7XDaS5JTjyQ3xTVn2Qzat1hJqnHaRnwkrcpm1I
 Tk6gjYQLscfgDlKOHpEdiNoP9s2jMJJF926EXcK8410q10pL6LOKO6wkEbW7rSwM1Zeg
 sqtBLknqCtGMNr2OwtFGRuLvBliS4Zg8lJ3Xo2fqxG3lMWbKQRL7tJUu22ar6h7B3pLG
 h432rlk/vSzKx3pBpI+WTeL+Ne1lLvwcynkFxd57BQq49abdR1S93Ak1CuzeDoBkBDj+
 zb1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kddPZ/jPqgZ7KgyicYawVo+muR5eePTSfHbxJ3GUdP4phwpqtUu7Mhu6L4lFUnkmmIpsjK8uL0+8t@nongnu.org
X-Gm-Message-State: AOJu0YylnCv41W3WDmoVyVlLsPOy9tDN6srA1DcRwjnaT2ydLpifJ0/o
 t915LN3K4Uro7LUIqz9a13x2oiCpnh+C8CvL55SY03foVT4z5n9tOrJ3FIrl+qT9KVEgzWysOP9
 Z3WzWov7q3VvD9E9XCeylVAHgSZbJ+is7ibNKHpY/RtC+YlGr9IwnWxvZmLTZbJ7hJA==
X-Gm-Gg: Acq92OHaxLc4SKjxS7pZRgrKy0R+OzH0Rm62D5M9dCyOhBbGm581ezX6ahxLJ7Aa10F
 UrCij0/X6RH8Skq5WggJ1uQiNbaEebFCaIyvZ4cEnEuOCmAzSVL1xKoa4TVIJ/c9dNoamZi8y6R
 U8IlksmWfo9vdQDbcMqugfmAybIosUexi8w8S+Kc2G8npL8YbRDyQau+VvUXH1MDY5AqcnLyJTY
 44HX/dQhXQR6EIyg4bFKTmwAzMOYid9JnEGQV1KQfjABDIb/dYFbYgN2v6PPVAi+oHwh/kCcfjy
 J7i+rgNPWkBLxm0JKEVkcUtOCjis0/1n8N+jBCSPtQCIJHv5enpacKCTduhVg0ZHYlqZVACSoAZ
 /i+1cR+pSZqTjZ8xzMG+WwGO4dfu9ktTp/ubfmJoiHR6bstwTXcBE9mG/zZUVu2tVfiTRvamO
X-Received: by 2002:a05:620a:a416:20b0:918:4137:6be with SMTP id
 af79cd13be357-9184137090fmr1307524085a.53.1781571617713; 
 Mon, 15 Jun 2026 18:00:17 -0700 (PDT)
X-Received: by 2002:a05:620a:a416:20b0:918:4137:6be with SMTP id
 af79cd13be357-9184137090fmr1307517685a.53.1781571617177; 
 Mon, 15 Jun 2026 18:00:17 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa8b423sm32990475e9.11.2026.06.15.18.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 18:00:15 -0700 (PDT)
Message-ID: <1b43d007-ba84-4ce8-abde-f242bf817ad6@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 03:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] igb: Define TRL registers and core state
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX3N84YAGBP8wB
 geO5oCfNTDbN3ZLZCdjRzph45XcXFi/zS0iFWRbjKwKIyt15WfmgnUgKRAPE74t6nBytLW4PLiB
 60KcCNJi1T4JYaWotEQWU2+WZ4M/4Qk=
X-Proofpoint-GUID: DY8GvlLweoICmwxCOJAGLd6b5Zbe6ST1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfXzmEeEns+yTn/
 YZMDY3dme99koqSJ1vtROJmPb0ngyWP+ewmtnmUwmj+uqtjjTROQPMBL+L8NBrz1BrICyMu0lhu
 bmHDiJCL+k25kiV1I0/h1WqwevTylUAyH+/LuYnUE8MaxKEhPBMIdLdSTPPmLgBnxw8gZrhfZpk
 q4aXPgXCSvxoNslj7oBBpm3x4ldF3oYV2GWWzSWIn4D/cBFjVkTpb8H/mPHYQijLVVwNsi/4Aaz
 5Uuh61GggZAZwYhkfExdZDZCSn4aWq3Smpk94OsA8rlQQnajLQrQWJ06r5LeIQYxon8Bd3brKgj
 Ck5w1UqHCDcSs/MJRL7cpnIO9kMT+0lCbaPsqypQHwPtHYhSwKUXgy47wqP02VMoMp8O6/ZU0Zu
 Nuk9vwx7q73t3cyES8lsS7ymUi3mEOUINz7qRDlDbVP6k3K4Yk1kVd8pn2nydEKBirGbk+oNLIb
 KVsu2e/A30ooTqUDjVg==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a30a022 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1XWaLZrsAAAA:8 a=3OPROYpsI0mELyp5-YsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: DY8GvlLweoICmwxCOJAGLd6b5Zbe6ST1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160006
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

On 16/6/26 00:18, Josh Hilke wrote:
> Introduce register offsets and bitmask constants for the Transmit Rate
> Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
> IGBCore to track TRL state (timers, throttling status, and target rates)
> per queue. Initialize and free these timers during the device
> realize/uninit lifecycle, and reset them on device reset.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_core.h   | 13 ++++++++++++
>   hw/net/igb_regs.h   |  6 ++++++
>   4 files changed, 79 insertions(+)


> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index d70b54e..f3d50bc 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -63,6 +63,13 @@ typedef struct IGBIntrDelayTimer_st {
>       IGBCore *core;
>   } IGBIntrDelayTimer;
>   
> +typedef struct IGBTrlQueue_st {
> +    QEMUTimer *timer;
> +    IGBCore *core;
> +    int queue_idx;
> +    uint32_t trlrc;
> +} IGBTrlQueue;
> +
>   struct IGBCore {
>       uint32_t mac[E1000E_MAC_SIZE];
>       uint16_t phy[MAX_PHY_REG_ADDRESS + 1];
> @@ -99,6 +106,9 @@ struct IGBCore {
>       void (*owner_start_recv)(PCIDevice *d);
>   
>       int64_t timadj;
> +
> +    /* Transmit Rate Limiting */
> +    IGBTrlQueue trl[IGB_NUM_QUEUES];
>   };
>   
>   void
> @@ -143,4 +153,7 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
>   void
>   igb_start_recv(IGBCore *core);
>   
> +bool igb_trl_enabled(uint32_t trlrc);

    bool igb_trl_enabled(const IGBTrlQueue *q);

> +uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q);
> +
>   #endif

