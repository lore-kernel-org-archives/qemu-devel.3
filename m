Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C95CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkRH-0007uM-7C; Tue, 13 Oct 2026 17:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkRF-0007tr-1E
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:53:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkRC-00058O-DF
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:53:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLRMR11404185
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pEOaHw0qnQTyU1PzkHtib02+UI6HE4tnFg9CnmqsN/E=; b=gSh+xOA/OABi+O6y
 YXMEbxf6mYFH+FBFSO2Tcu9DkL2zNsdCH6rjk9zJBpz+73mN3+Gsg9Valn0sbYSX
 Y8H2rL9b21wFuPPu9evgWg94K6oox3bLX0OzWENF5f/cAkHHbgE5VsMt4/7lwajj
 FDLKvewgJzmWW4151gFMPmxVMwMeyCoieDrx4TcZeXUo5+Lf33bO2VWILZgg6lxD
 YbNwxbo8FznNN3f1Wsi3WPTsULCxC2MhWaX6cU3/s7DJB7Ki1ffQuRJXavBpHXbM
 HeX9X65maiASYDNvb1/COgA1Ce5v+4Py7F1xUOje6bbpKh+pol3mhEaI8he8UNad
 +Cc65w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk1tdu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:53:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so7155328eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791928412; x=1792533212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEOaHw0qnQTyU1PzkHtib02+UI6HE4tnFg9CnmqsN/E=;
 b=CeFEYMaQAG/RFYnr+F3FZE5HSmV42khC6CdOkeqju7m8D17iIdcVUSCS4F//XxDQTR
 JZpgUXixf1dnH9lQV9let5Ov3jm11FghDeNd2cr404QqbVrSZhi9rlHhZNSxI3zpOyDY
 Cdko/4tb4tzt6+I9/7tZVRfxBES235b797d05kF88wATE2tnAr32Rw2SMGJyQqvXAF1m
 X7D4KhUyH0vEN77xHztKJRye7SH8yRoELoF55LxfVYx/YLPRY1JSj2pRA1T0esKa+Uqy
 VDiPZVkSRdP8aXScBLw9qkxGo20/k9AiXyIUuob88cVMKQZ7dhgblfV6omRsxU/K6TQy
 3Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928412; x=1792533212;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pEOaHw0qnQTyU1PzkHtib02+UI6HE4tnFg9CnmqsN/E=;
 b=2UcXJlN4I77vYqEr8ptNfAS2tFFSRhFbUacu0pFVygFxAGHL9Slz0hGg6u2Zd2MhsO
 6dGLONgJR+fMhbweh06c6wqF1BowBbSWV6I9Cl3aOhT8bWZzjh6Bm25swKn3pmo9rhk4
 DbftSmZrLE3oEdMV17gus7hP/hWroE22fnCBratScwvEY2kEajBtVNJSRRnBJqr9Usle
 tx7HJg6wdB8GzXAjws+k/i2a8YeicC7HPk25z9xLQWP0LXAKkDzF5MHis8PyA3ezq2V0
 eJ9UfUmhBiEhzdgGp69gz6C8rZlMGFXrOdWgbD8/in1tjtHauvRuWaKk/i3yHA+DWegD
 TAxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4b2ASSwAH2KHkJBdqQtZggKMUhAiAWozF1K2QtevmK/trhJzGGZ+1I8Uclx9c7PYHHLpUkv4qdqLx@nongnu.org
X-Gm-Message-State: AFq9FYKxj4hXsmfYgz4tqBoQIabg4McWm/ohFRP4jUKiZ8/M40OPdn7w
 X4aiL0SgXhbFOOMuhvoBGbpNXdgyK5O1N1Ez1VRoNZ2fqkiz5m+oEfaFPSlyNAytkt82TrS1Tu5
 mbvE4YIL/1KZ29vBDxWvDfzWFOtxK8bpXGzbnUoQOsZhD49D5RwdnLvmaOA==
X-Gm-Gg: AYBFou1zTYJbXxquRn+BQCcWykVK56uT/GjN4ea+aKeB5ZHmyIPWr8A48XJNq332cmt
 g+a+VzhlQ1G2qcQ0ZlPZIKlChDIr1BZf2HgOgRNRGVNTBR3p1/1ZhX96YOxnGkfA0CwLzjh8GrT
 UknzD+Ok4g5O0dfz//dSX2CdKQSxQ+kbuHNN58fFQG3LyxkK++/TYGEzHSytPI0xmG+5tg/0Hab
 5V/v/LOEVZJGt3iI4u+N+Zqp2b/TjGTlvW8Q+Furo3Fksfq1a64ElWWCAW6fIhQDWaI5iBwYqSV
 3MuOodf+oKeZsjSCwgnVJGI+/8thxdTstaqQQQoIMFS7ZQaxze78pamgLzkGso4tx0Cz4CXyE8w
 fYjlgBu082sRwmrFRp/TXQks34FKZNK9TN8z/pwFLLq6921HtaHHPr0XNEN8Jx4GDsA2oJw==
X-Received: by 2002:a05:7301:5f0b:b0:351:4648:3611 with SMTP id
 5a478bee46e88-3537e1118bcmr17351972eec.26.1791928411626; 
 Tue, 13 Oct 2026 14:53:31 -0700 (PDT)
X-Received: by 2002:a05:7301:5f0b:b0:351:4648:3611 with SMTP id
 5a478bee46e88-3537e1118bcmr17351939eec.26.1791928411089; 
 Tue, 13 Oct 2026 14:53:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm19887808eec.24.2026.10.13.14.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:53:30 -0700 (PDT)
Message-ID: <1784c4a7-8929-4695-8d23-4a69a8c7092b@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:53:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/hexagon: set a started thread's enable bit
 when start retires
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009192541.4163758-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eHL8A5VNFlMOP9sxaJO8yVUd79mwnNgD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX3Ich9bvlt1Ua
 XqwnaI7Uu3cAfzKIwV6/DiYRbtjqNEUw1P9j6efYtoN8CllJ2nxEFr2peXbfp3TGdKmN1RvMyAV
 ltnAxo9BDg4C84sll0csxj/stVZnnNM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX0QsVlQA53oCz
 z/+Rrxngb6oQHrif8bXMCCOja2ntE+VcSkdq99NXE+v1RcwNAp6nuHAs/7SnekkoVhjVK8JIErG
 Gr3UDuOa9UL9Wh3Vm3xkKgMuQwWQgeQwahsY7tzje15lw8rmJdNzlKAR3klwa249h9EnX0LhIxr
 v6E/pBUFkva2NlY+Jug72tyk3oEZkTsd0QcknS1ewMd+/spc/aBeqUaiRehSRDeMLvbLbW5ZPGN
 3IYaZmZ+rQ+I9CJjVFBervlGv11qE9rqXR12ZBxWi/cx2tT8X2FcBLZ4JYDLkcSWIxr6yAINE5o
 mkbfFsBwiIVsQCVgzKDnVmO0U/xIQ0cAR9vS82/cUN8fR7XAO1tSMxW2UyczArbwlG6L7N6ruS9
 LKGDHtlDcGDLVvFT0ZvfQlgDoYSzrK95Lc2fUPXvTyuTNR3V0mfQQUdX4p1ywB1/PASm5JHUvFV
 LXTcVFnNLY/Zyc1uHBQ==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6acea85c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Xz4L5JObOgox9MjymXsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: eHL8A5VNFlMOP9sxaJO8yVUd79mwnNgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/9/2026 12:25 PM, Brian Cain wrote:
> Set MODECTL.E when start retires rather than when the target thread runs. This
> makes the thread state visible to software immediately after start.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

