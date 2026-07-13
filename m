Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71BAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEpi-00070u-3y; Mon, 13 Jul 2026 07:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEph-00070j-6c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:28:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEpf-0000Px-Da
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:28:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9R6eT1122891
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 glcDPzcN1WLQPiWVuwh3aPS8v2o+iRyjebLoh+k+vl0=; b=PMEG1vuEmINSfp5D
 LWk7/yEHIXd33tPI9M+Vosex0ald//v3Q+TChukuJXz1036uS8xAc75BbrJ17WF6
 ORfPO5ehhd5FH23LoPKHou6eJqxYBaG05gTwsLquJHzcJOvdo1wDS9Ls4CZon4m1
 lSVD8CWf9rrw8wuICGHujLJQ1xWukkqBcNJbNKsFSv2rnHYMXEwNxcxUCxNP28af
 nYgBbft91G3jj3WQ8iFubDyerqR29yRejFVrl/jvg/KkEYRcFBg85IfNUS4z3Zle
 dSoqjsi9mqkRsLCHNwbvTVwkBzIIRB10ZlrWK3txcBN3GHalnp5SJuLOpE+0JjcG
 Jx20Gw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda0du7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:28:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so51713741cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783942097; x=1784546897; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=glcDPzcN1WLQPiWVuwh3aPS8v2o+iRyjebLoh+k+vl0=;
 b=YZGqj3dPqUFpIPSTrWbLURIVWbOBVuZYuZpUrDhDd0faEP0DShM/aflTXcM5gC0uxy
 qnXDPWT5vlF87BxirCmqhb7T936MJ/Vznm8npjVuVGrZlbuHXbRRiXstuyTNxmNS9LE6
 IpfegJXD5jkZnYitgAvOW/QkH2cdhy1Z0y9Bmt5o2VO4pLGI/2cZGqrlk48p7FJGSQwO
 RljcyacSIjoSP8Y5BAQZNYlk4xa9FtSEJsSEgqPYMxIuTD90nzcV1Q25K33hNOdtQRtA
 KupOyutpIPQ7GLKxz/c/kYi2HxCbDwcxVWvyq7c/9NOYmN+o/VDAX1iZrW5FYECxyMCV
 qtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942097; x=1784546897;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=glcDPzcN1WLQPiWVuwh3aPS8v2o+iRyjebLoh+k+vl0=;
 b=fIO4SBBZgnAOHRPJGtpDgsu15sHJNz5CA8HDnXrYNJjDvPivXEMiWU3G/u5GvSE6sS
 jA3zOBw2fq/v+1sS4hn+0+LCZq77i5CVyKrinUUoOy53ALDovFSorUIBKAxgB9nlw+Oy
 3lKFZSY86X1DJznN7TQf1mMQyDFVaYrY/XoOBLXlq5OREUDC1SGco5j85XyfRrWf/okG
 blab3eur9mdJzZKxWh9YJcCmF9cCP5WXO0RMzfn0sx8K9HTAQNfP3cTZir31dCsdl8fL
 ye2pcoWcHh1iR/AyNpgb8k/ALGCbolrkxrdRroD6OI9TZou65RGGbw7PK+27c91MLYTC
 0wWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCTP18cY/GTjISdZcnCFri8cIyYr/Rnisth83cgDAabbDYTY03wPO2rAY6vS9d1sYjessP+zahSknI@nongnu.org
X-Gm-Message-State: AOJu0YxCJmAOzTEiKRs/wfqSw0s9Xu8116oBuqIY0DMNNnuG6re1sFw0
 7gn9qcQs3RdvhNKlrH74flPuU5Wfck7nMUIpBYMrRyKoafjShXf28dnNLaGH0HybWTNlvjsjWCv
 VxysFJFI0N1zDcQFpUwtpP0lUvGPcoh3ya8oZ2NDANaY2IxRHQ0N6a6UneQ==
X-Gm-Gg: AfdE7cmcT4MtTOds2E6nS20g7Y+tUwv+46kJFsLRFSkTwlhQNwUW0mZgdBEdFwYyYl8
 WM/uA2FyuL/G+7jME602AELZEEfRSD1zdt6yfq2QADISPlW4XM629cBv6BlbuLPMlxRTd9eIZ1o
 XCjfdC4o0WbGqz8EKfXjrFGH8stpn/27/3519wAqwOaiR2knESQjUK3abGVYHaieQU2Ww8zOqaX
 ikLadI8e2UR9/PV+nQOXHhHOW6GxmPFiZKXXPK8OmHV4RyNTtaV18LMF7I9c/dHXo6HgTsOCqUm
 R9zHygilJZV+dud6aRwjbcXW3L1ByTMg62jV4wijxF/r/TRPXRk8wlWEwBZDArZnWdVbLibh2uP
 mrt0AvkihAmizJu1h+35QWg3D8GVdrjOJNWkVwX8q6wpOVUeLMHo5+QzzHua3bA==
X-Received: by 2002:ac8:7dce:0:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-51cbf247d0fmr83784451cf.37.1783942097355; 
 Mon, 13 Jul 2026 04:28:17 -0700 (PDT)
X-Received: by 2002:ac8:7dce:0:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-51cbf247d0fmr83784241cf.37.1783942096953; 
 Mon, 13 Jul 2026 04:28:16 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm82553610f8f.13.2026.07.13.04.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:28:16 -0700 (PDT)
Message-ID: <cd0495e5-e63f-4931-ab57-fcf213cb164d@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ui/vnc: use RFB wire types for client message handlers
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-4-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-4-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMCBTYWx0ZWRfX7uvUMGXu23Xn
 0skAU+RteTe7w36QO8qQDfxF9fMcG6Pee+CaoZh0TW+Bi3+L3+RbqDQsCjbZsR7wqbsJEc9IJv1
 cVvVb62vlr7ZTEDoPpLpIIM4tJ9tieg=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54cbd2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=r0bVYnQz3-FgjroSeqQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: MxlHVJmQ9w-aOK35Oc14cqRq-JPfeZQy
X-Proofpoint-ORIG-GUID: MxlHVJmQ9w-aOK35Oc14cqRq-JPfeZQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMCBTYWx0ZWRfXy+Vb7xKJwnlX
 UfJABqNzukWjx4RDnrFE/0gt7n0YfssbXJB9PRBmUGgtiR1jw+CMGES5wDR/6hilfKARhh9N3mk
 Eyko2EQF0sMhDYTr4u4AcWRIQUiOgKBI1fvSA676VdlLfKgFAPg+q3fj5hgQYUmHTExT8Z/qMHD
 2J/FttOaMM2u1wW0gcWr1wXixw7qM1gLhFYyNSfXulG9gU40LsLFAEoal6xIMNzgqmake1UpRim
 FdHcVQ6pELC8MP2Os+ZY8fbNNNbdo3BqYWALql2seh1GyE9RFVoy9JpzrrdX+6byp8sEfZlD9gC
 UP2sd2rSXK/5n3E5XFinsmDP6ZDxupOdArPUQoIlESWlW8ubJqLY3Uu9MoDajHfAEdguRjeMtYp
 EAsm+wcGKme5UGkWhOCy8T4uEWnG/opl7jjL2Dy8BiskVNI8NcqRTQpPm9/3xS8+Hn5Ibrtt5Si
 scypMgRCi7ZqA7WSAcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130120
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

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> Use exact-width unsigned types for the static functions that process
> RFB client messages, matching the types returned by read_u8(),
> read_u16(), and read_u32():
> 
>   - set_pixel_format: uint8_t/uint16_t for pixel format fields
>   - pointer_event: uint8_t button_mask, uint16_t x/y
>   - key_event/ext_key_event: bool down, uint32_t sym/keycode
>   - do_key_event: uint32_t sym
>   - framebuffer_update_request: uint8_t incremental, uint16_t x/y/w/h
> 
> Drop needless declarations.
> 
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 33 ++++++++++++++-------------------
>   1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 94a38242c56..14ce2816907 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -608,15 +608,7 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
>      3) resolutions > 1024
>   */
>   
> -static int vnc_update_client(VncState *vs, int has_dirty);
> -static void vnc_disconnect_start(VncState *vs);
> -
>   static void vnc_colordepth(VncState *vs);
> -static void framebuffer_update_request(VncState *vs, int incremental,
> -                                       int x_position, int y_position,
> -                                       int w, int h);
> -static void vnc_refresh(DisplayChangeListener *dcl);
> -static int vnc_refresh_server_surface(VncDisplay *vd);
>   
>   static int vnc_width(VncDisplay *vd)
>   {
> @@ -1763,7 +1755,8 @@ static void check_pointer_type_change(Notifier *notifier, void *data)
>       vs->absolute = absolute;
>   }
>   
> -static void pointer_event(VncState *vs, int button_mask, int x, int y)
> +static void pointer_event(VncState *vs, uint8_t button_mask,
> +                          uint16_t x, uint16_t y)
>   {
>       static uint32_t bmap[INPUT_BUTTON__MAX] = {
>           [INPUT_BUTTON_LEFT]       = 0x01,
> @@ -1841,7 +1834,7 @@ static void kbd_leds(Notifier *notifier, void *data)
>       }
>   }
>   
> -static void do_key_event(VncState *vs, int down, int keycode, int sym)
> +static void do_key_event(VncState *vs, int down, int keycode, uint32_t sym)

bool down.

>   {
>       unsigned int lnx = qemu_input_key_number_to_linux(keycode);
>   
> @@ -2019,7 +2012,7 @@ static const char *code2name(int keycode)
>       return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
>   }
>   
> -static void key_event(VncState *vs, int down, uint32_t sym)
> +static void key_event(VncState *vs, bool down, uint32_t sym)
>   {
>       int keycode;
>       int lsym = sym;
> @@ -2034,8 +2027,8 @@ static void key_event(VncState *vs, int down, uint32_t sym)
>       do_key_event(vs, down, keycode, sym);
>   }
>   
> -static void ext_key_event(VncState *vs, int down,
> -                          uint32_t sym, uint16_t keycode)
> +static void ext_key_event(VncState *vs, bool down,
> +                          uint32_t sym, uint32_t keycode)
>   {
>       /* if the user specifies a keyboard layout, always use it */
>       if (keyboard_layout) {
> @@ -2046,8 +2039,9 @@ static void ext_key_event(VncState *vs, int down,
>       }
>   }
>   
> -static void framebuffer_update_request(VncState *vs, int incremental,
> -                                       int x, int y, int w, int h)
> +static void framebuffer_update_request(VncState *vs, uint8_t incremental,
> +                                       uint16_t x, uint16_t y,
> +                                       uint16_t w, uint16_t h)
>   {
>       if (incremental) {
>           if (vs->update != VNC_STATE_UPDATE_FORCE) {
> @@ -2250,10 +2244,11 @@ static void send_color_map(VncState *vs)
>       vnc_unlock_output(vs);
>   }
>   
> -static void set_pixel_format(VncState *vs, int bits_per_pixel,
> -                             int big_endian_flag, int true_color_flag,
> -                             int red_max, int green_max, int blue_max,
> -                             int red_shift, int green_shift, int blue_shift)
> +static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
> +                             uint8_t big_endian_flag, uint8_t true_color_flag,

bool flag, bool flag.

> +                             uint16_t red_max, uint16_t green_max,
> +                             uint16_t blue_max, uint8_t red_shift,
> +                             uint8_t green_shift, uint8_t blue_shift)
>   {
>       if (!true_color_flag) {
>           /* Expose a reasonable default 256 color map */
> 

Including the (uint32_t) casts in this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

